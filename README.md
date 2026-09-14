# portable_configs

To store configs for various applications such as vim, tmux, alacritty

Git clone

```bash
git clone https://github.com/atul4sharma/dotfiles.git
```

## Usage

The configs live in this repo; the machine gets symlinks pointing back at them, so editing a
config in either place edits the same file and the repo is never out of date.

```bash
./dotfile_repo_updater.fish            # report the state of every link (default)
./dotfile_repo_updater.fish link       # create/repair the links on this machine
./dotfile_repo_updater.fish brew       # dump brew_packages/Brewfile from installed packages
```

`link` backs up anything real it finds in the way as `<path>.bak.<timestamp>` before linking. If a
path is already a symlink pointing somewhere other than this repo, it reports an error and leaves
it alone rather than clobbering it.

The managed paths are listed in `managed_links` at the top of `dotfile_repo_updater.fish`. Add a
config by putting the file in the repo and appending a `live_location,path_in_repo` entry.
