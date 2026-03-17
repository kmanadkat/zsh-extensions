# ZSH Extensions

A collection of simple ZSH plugins to enhance your shell prompt with useful information.

## Plugins

### language.zsh
Displays the version of Node.js or Python when in a relevant project directory.

- Detects Node.js projects by presence of `package.json`
- Detects Python projects by presence of `pyproject.toml`, `requirements.txt`, `setup.py`, or `Pipfile`
- Prioritizes virtual environment name and Python version if active

### git.zsh
Shows the current git branch and various status indicators.

Indicators:
- `++n`: Added files
- `+n`: Staged changes
- `!n`: Modified files
- `?n`: Untracked files
- `✘n`: Deleted files
- `↑n`: Commits ahead of upstream
- `↓n`: Commits behind upstream
- `⚑n`: Stashed changes

### timer.zsh
Displays the execution time of the last command if it took more than 2 seconds.


## Requirements

- ZSH shell
- MesloLGS NF Font (or any compatible Nerd Font) for proper icon display in the terminal


## Installation

1. Clone this repository into your home directory:

   ```bash
   git clone https://github.com/yourusername/krupesh-zsh.git ~/.custom-zsh
   ```

2. Add the following to your `~/.zshrc`:

   ```bash
   # Custom ZSH Plugins
   for file in ~/.custom-zsh/*.zsh; do
     source "$file"
   done

   setopt PROMPT_SUBST

   PROMPT='%F{39} %f%F{75}%1~%f $(git_segment) %F{46}❯%f '
   RPROMPT='$(language_segment)%F{242}$(cmd_duration_segment)%D{%I:%M %p}%f'
   ```

3. Reload your ZSH configuration:

   ```bash
   source ~/.zshrc
   ```

## Requirements

- ZSH shell
- Git (for git segment)
- Node.js (optional, for language segment)
- Python (optional, for language segment)

## Customization

You can modify the prompt in your `.zshrc` to suit your preferences. The segments are:

- `$(git_segment)`: Git information
- `$(language_segment)`: Language version
- `$(cmd_duration_segment)`: Command duration
