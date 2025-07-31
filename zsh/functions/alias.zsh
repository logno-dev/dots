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

alias pc="wakeonlan 2C:F0:5D:8A:43:68"

alias note='nvim -c "normal G" ~/notes.wiki/general.org'

alias cd="z"
