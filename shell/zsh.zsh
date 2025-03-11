autoload -U add-zsh-hook
autoload -Uz compinit

setopt interactive_comments
setopt cd_silent
setopt cdablevars

bindkey '^ ' autosuggest-accept

export PATH=$HOME/bin:$HOME/.config/zsh/scripts:$HOME/.cargo/bin:$PATH
export PNPM_HOME=$HOME/bin

# Make 'cdpath' suggestions stand out
# https://superuser.com/questions/265547/zsh-cdpath-and-autocompletion
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{magenta}%B%U%d%b%u%f

# https://stackoverflow.com/questions/24226685/have-zsh-return-case-insensitive-auto-complete-matches-but-prefer-exact-matches
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# https://esham.io/2023/10/direnv
export DIRENV_LOG_FORMAT=

# Font Dir
LOCAL_FONT_DIR="$HOME/.local/share/fonts"
if ! [ -L "$LOCAL_FONT_DIR" ]; then ln -s "/run/current-system/sw/share/X11/fonts" "$LOCAL_FONT_DIR"; fi;

# FNM
eval "$(fnm env --use-on-cd)"

repo_root() {
  cd $(git rev-parse --show-toplevel 2>/dev/null || echo $PWD)
}

# TODO: Can this be done with Home Manager?
alias -g G='| grep'
alias -g B='| bat'

which='(alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot'

__installed() {
  (which $1 > /dev/null 2>&1)
  echo $?
}

echoerr() { cat <<< "$@" 1>&2; }

# Steam
__steam_game_defs() {
  ACF_INSTALLED=$(__installed acf)
  JQ_INSTALLED=$(__installed jq)

  if [[ $ACF_INSTALLED -gt 0 ]] || [[ $JQ_INSTALLED -gt 0 ]]; then
    echoerr "Prerequisites not satisfied, try: nix-shell -p steam-acf jq"
    return
  fi

  find ~/.local/share/Steam/steamapps -maxdepth 1 -type f -name '*.acf' -exec \
    sh -c "acf {} | jq -r '.AppState | {id: .appid, name: .name}'" \; \
    | jq -s '. | map(select((.name | test(".*(Proton|Steam Linux|Steamworks).*") | not)))'
}

games() {
  __steam_game_defs \
    | jq -r '. | map("\(.name);\(.id)") | join("\n")'\
    | column --table --table-columns NAME,ID -s ';'
}

game() {
  if [[ $# -eq 0 ]]; then;
    SELECTION=$(__steam_game_defs \
  |   jq -r ".[] | select(.name == \"$(__steam_game_defs \
    | jq -r 'map(.name) | join("\n")' \
    | fzf +m --cycle --border --layout=reverse)\") | .id")
  else
    SELECTION=$1
  fi

  steam steam://rungameid/$SELECTION
}

_game() {
  _alternative "args:Installed Games:$(__steam_game_defs \
  | jq -r '"((\(. | map("\(.id)\\:\"\(.name)\"") | join(" "))))"')"
}

compdef _game game

__steam_game_defs | jq -r '.[]|[.id, .name] | @tsv' |
  while IFS=$'\t' read -r id name; do
    ALIAS_NAME=$(tr -dc 'a-zA-z0-9' <<< "$name" | tr '[:upper:]' '[:lower:]')
    alias "$ALIAS_NAME"="steam steam://rungameid/$id"
  done

# https://github.com/o2sh/onefetch/wiki/getting-started#1-bash--zsh
last_repository=
__check_directory_for_new_repository() {
  current_repository=$(git rev-parse --show-toplevel 2> /dev/null)

  if [ "$current_repository" ] && [ "$current_repository" != "$last_repository" ]; then
    onefetch --nerd-fonts --no-art -d created -d authors -d contributors -d dependencies
  fi

  last_repository="$current_repository"
}

__setup_case_insensitive_cdpath() {
  while IFS= read -d ':' -r cdpath_el; do
    for el in $(\ls $cdpath_el); do
      BASE_NAME=$(basename "$el")
      ALIAS_NAME=$(tr -dc 'a-zA-z0-9' <<< "$BASE_NAME" | tr '[:upper:]' '[:lower:]')
      [[ "$ALIAS_NAME" != "$BASE_NAME" ]] && alias "$ALIAS_NAME"="cd $el"
    done
  done < <(printf "%s\n" "$CDPATH")
}

# Only run in Interactive Prompts
[[ $- == *i* ]] && {
  eval "$(atuin init zsh)"
  eval "$(starship init zsh)"

  add-zsh-hook chpwd __check_directory_for_new_repository

  __setup_case_insensitive_cdpath

  # Only run Macchina if not in VSCode, Jetbrains IDEs, or Emacs
  [[ "$TERM_PROGRAM" != "vscode" \
    && -z $EMACS_VTERM_PATH \
    && -z $FIG_JETBRAINS_SHELL_INTEGRATION ]] && {
      # Use Rainbow Version on Rainbow Machine
      [[ $(hostname) == "RainbowMachine" ]] \
        && macchina | lolcat -tp 2.0 || {
        # TODO: This is terrible
        macchina | sed "s/RainbowMachine /Zephyrus ──────/g"
      }
    }
  }

compinit
rehash
