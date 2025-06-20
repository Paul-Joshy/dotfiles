#!/usr/bin/env bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \\n    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
curl --create-dirs -o ~/.config/up/up.sh https://raw.githubusercontent.com/shannonmoeller/up/master/up.sh;
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash;
