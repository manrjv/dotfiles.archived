# dotfiles

NOTE: I am currently not using this repository to manage my dotfiles. I am trying out GNU Stow.

## Instructions for managing my dotfiles using a bare repository

This approach is specific to GitHub. It avoids manually editing the git config and HEAD files in order to replace "master" with "main" (does not apply if using [Git 2.28](https://github.blog/2020-07-27-highlights-from-git-2-28/)). These instructions are derived from the tutorial that can be found by following this [link](https://www.atlassian.com/git/tutorials/dotfiles), and there are others like it on the web.

1. Create a GitHub repository.

* Select **Add a README file** to initialize the repository. This is key to not having to edit the git config and HEAD files.

2. Clone the new repository, create an alias for the git command, configure git to not show untracked files, and checkout the repository.
```sh
git clone --bare git@github.com:manrjv/dotfiles.git $HOME/.dotfiles.git
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
dotgit config --local status.showUntrackedFiles no
dotgit checkout
```
* `dotgit checkout` will copy the files into the $HOME directory. If the files already exist in the $HOME directory, delete them or move them to a different directory before doing the checkout. (Initially, only "README.md" exists in the repository, so it will be the only one that will be copied.)

3. Add the alias to .bashrc and/or .zshrc.
```sh
echo "alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'" >>~/.bashrc
echo "alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'" >>~/.zshrc
```
4. Edit `.gitignore` to exclude all files and subdirectories except those implicitly included. Use `dotgit status -u` to verify that `.gitignore` is doing what is expected.

5. Add the dotfiles to the repository.
```sh
dotgit add .bashrc
dotgit commit -m "add bashrc"
dotgit push --set-upstream origin main
```
* `--set-upstream origin main` is needed only for the first push.

## Things to consider:
* One negative with this approach to managing dotfiles is that VIM is not aware that the files are being managed using git. There is probably a way to handle this, and I just don't know about it at this time.
