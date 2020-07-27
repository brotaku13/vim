#!/bin/bash 

# use these environment variables
user_home_dir='~'
user_bin_dir='~/bin'
root_access=false

# set up the platform os
platform=''
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	platform="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	platform="mac"
else
	echo "This script does not support this OS"
	exit 1
fi

echo "detected platform = $platform"

# check for root access
echo "Checking for root access"
if [[ $(id -u) -ne 0 ]]; then
	echo "No root access detected"
	root_access=false
else
	echo "root access detected"
	root_access=true
fi

echo "detected root access = $root_access"

function check_install(){
	# checking installation
	echo "Checking installation..."
	if which $1 &> /dev/null; then
		echo "installation successful!"
	else
		echo "Something went wrong during the process :( "
		exit 1
	fi

}

# $1 is the name of the program, $2 is the bin path
function add_to_path() {
	echo "\nAdding $1 to PATH" >> $user_home_dir/.bashrc
	echo "PATH=$PATH:$2" >> $user_home_dir/.bashrc
	source $user_home_dir/.bashrc
}

function create_user_bin(){
	if [ -d $user_bin_dir ]; then
		echo "user bin dir already created"
		return
	fi

	echo "Creating a user bin directory in $user_bin_dir"
	mkdir -p $user_bin_dir
}

function install_neovim() {
	if which nvim &> /dev/null; then
		echo "Neovim already installed!"
		return
	fi

	echo "Installing Neovim"
	echo "$platform" "$root_access"	
	if [[ "$platform" == "mac" ]]; then 
		brew install veovim

	elif [[ "$platform" = "linux" ]] && [[ ! $root_access ]]; then
		
		# user does not have root access, install via wget
		nvim_url="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"
		filename='nvim-linux64'

		# download file
		echo "Downloading Neovim from github"
		curl -o $filename -L $nvim_url
		
		# extract file to the bin directory 	
		echo "extracting to bin directory located at $user_bin_dir"
		tar -xzf $filename -C $user_bin_dir

		# add that file to the path
		echo "Installing on path"
		add_to_path "nvim" $user_bin_dir/$filename/bin
		echo "alias vim='nvim'" >> $user_home_dir/.bashrc

		rm -rf $filename
	else
		# have root access just use package manager
		sudo apt install neovim
	fi
	
	check_install nvim

	echo "Cleaning up nvim install"
	rm -rf $filename
}

function install_nvim_config_file(){
	if [ ! -f ./init.vim ]; then
		echo "Could not find config fie. Be sure to run this script directly from the repo directory";
		exit 1
	fi
	if [ ! -d $user_home_dir/.config/nvim ]; then
		echo "Creating nvim config directory"
		mkdir -p $user_home_dir/.config/nvim
	fi

	echo "installing nvim config file"
	cp ./init.vim $user_home_dir/.config/nvim
	
	if [ $? == 1 ]; then
		echo "Could not copy config file"
		exit 1
	fi
}

function install_nvim_plugin_manager(){
	echo "Installing Plugin Manager"
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

function install_rg() {
	echo "Installing ripgrep"
	if which rg &> /dev/null; then
		echo "ripgrep already installed"
	fi

	if [ "$platform" == "mac" ]; then
		brew install ripgrep
		 
	elif [[ "$platform" == "linux" && ! $root_access ]]; then
		# user does not have root access, install via wget
		rg_url="https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep-12.1.1-x86_64-unknown-linux-musl.tar.gz"
		filename='ripgrep-12.1.1-x86_64-unkown-linux-musl'

		# download file
		echo "Downloading ripgrep from github"
		curl -o $filename -L $rg_url
		
		# extract file to the bin directory 	
		echo "extracting to bin directory located at $user_bin_dir"
		tar -xzf $filename -C $user_bin_dir

		# add that file to the path
		echo "Installing on path"
		add_to_path "ripgrep" $user_bin_dir/$filename/bin

		rm -rf $filename
	else
		# have root access just use package manager
		sudo apt install ripgrep
	fi
	
	check_install rg

	echo "Cleaning up ripgrep install"
	rm -rf $filename
}

# CoC requires nodejs so we need to install that first
function install_node_js(){
	echo "installing node-js for the CoC vim plugin"
	if which node &> /dev/null; then
		echo "node-js is already installed"
		return
	fi
	
	if [[ "$platform" == "mac" || $root_access ]]; then
		curl -sL install-node.now.sh/lts | bash
	elif [ "$platform" == "linux" && ! $root_access ]; then 
		node_url='https://nodejs.org/download/release/latest/node-v14.6.0-linux-x64.tar.gz'
		filename='node-v14.6.0-linux-x64'
		
		echo "downloading node-js binaries"
		curl -O $filename -L $node_url

		echo "extracting to bin directory located at $user_bin_dir"
		tar -xzf $filename -C $user_bin_dir

		echo "altering path"
		add_to_path "node-js" $user_bin_dir/$filename/bin

	else
		echo "I'm confused about this whole node thing. Exiting."
		exit 1
	fi
	
	check_install node

	echo "Cleaning up node-js install"
	rm -rf $filename
}

function install_clangd(){
	echo "Installing clangd for the coc c/c++ plugin"
	if which clangd &> /dev/null; then
		echo "clangd is already installed"
		return
	fi
	
	if [ "$platform" == "mac" ]; then
		brew install clangd
		add_to_path "clangd" /usr/local/opt/llvm/bin

	elif [ "$platform" == "linux" && ! $root_access ]; then 
		clangd_url='https://github.com/clangd/clangd/releases/download/10.0.0/clangd-linux-10.0.0.zip'
		filename='clangd-linux-10.0.0.zip'
		
		echo "downloading clangd binaries"
		wget -cO - $clangd_url > $filename

		echo "extracting to bin directory located at $user_bin_dir"
		unzip $filename -d $user_bin_dir
		
		clangd_name="clangd_10.0.0"

		echo "altering path"
		add_to_path "clangd" $user_bin_dir/$clangd_name/bin
	elif [[ "$platform" == "linux" && $root_access ]]; then
		sudo apt install clangd
	fi
	
	check_install clangd

	rm -rf $filename $clangd_name
}



#vim_setup --home-dir {arg} --bin-dir-location {arg}
#vim_setup -h ~/some/path -b some/path/bin
	#if --no-root-access is provided, then use wget to install things
		#also use a bin dir in the home directory
			#if this arg is set, then we use this arg as the home dir - otherwise it uses ~

USAGE="\
Run this program from within the git repo. 
./vim_setup.sh [-h home-dir] [-b bin-dir]
	-d		specifies the user's home directory to use. Defaults to ~
	-b		specifies the user's bin directory. Use this if you don't have 
			root priveleges defaults to ~/bin 

If you have root access, run this script with sudo to use the OS package manager.
Without root access, the script will attempt to install all binaries into the specified
bin directory. 
"

function main(){
	while getopts d:b:h option
		do
			case "${option}" in
				d) user_home_dir=${OPTARG};;
				b) user_bin_dir=${OPTARG};;
				h) printf $USAGE; exit 0;;
			esac
		done

	echo "Running with user home dir = $user_home_dir and bin dir = $user_bin_dir"

	install_neovim
	install_nvim_config_file
	install_nvim_plugin_manager
	install_rg
	install_node_js
	install_clangd
	
	echo "Installation Finished. Don't forget to go into Neovim and run :PlugInstall to get all of the fancy plugins!"
	exit 0
}

main "$@"











