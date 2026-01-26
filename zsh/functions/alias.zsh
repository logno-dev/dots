alias vim="nvim"
alias code="nvim"

alias keygen="openssl rand -base64 32 | tr -d '\n' | pbcopy && echo 'Key copied to clipboard.'"

alias shadd="pnpm dlx shadcn@latest add ${@}"

alias l="lsd -1"
alias la="lsd -lA"
alias ls="lsd"
alias lt="lsd --tree"

alias tk="tmux kill-session -t"
alias tls="tmux ls"

alias p="cd ~/projects"

alias pc="wakeonlan A0:AD:9F:31:37:00"

alias note='nvim -c "normal G" ~/notes.wiki/general.org'

alias cd="z"

alias npm="pnpm"

mcd() {
  mkdir $1 && cd $1
}
