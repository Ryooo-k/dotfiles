eval "$(rbenv init -)"

# Gitブランチ情報の取得設定
autoload -Uz vcs_info
setopt prompt_subst
# ブランチ名を赤色（red）にする
zstyle ':vcs_info:git:*' formats '%F{red}(%b)%f'
precmd() { vcs_info }

# プロンプトの見た目（フォルダ名を緑、記号を黄色にする）
PROMPT='[%F{green}%c%f] ${vcs_info_msg_0_} %F{yellow}%%%f '

# エイリアスの設定
alias la='ls -a'
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gcm='git commit -m'
alias gcma='git commit --amend'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log'
alias gs='git status'
alias sqlite='sqlite3 db/development.sqlite3'
alias es='npx eslint'
alias pre='npx prettier --check'
alias r='bin/rails routes'
alias ta='PARALLEL_WORKERS=1 rails test:all'
alias tww='bin/rails tailwindcss:watch'
