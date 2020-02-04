for file in ~/.bash/*.bash; do
  source "${file}"
done

source /etc/bashrc_Apple_Terminal

unset DISPLAY

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="--height=40% --multi --tiebreak=begin \
  --bind 'ctrl-y:execute-silent(echo {} | pbcopy)' \
  --bind \"ctrl-o:execute-silent[tmux send-keys -t \{left\} :read Space ! Space echo Space && \
           tmux send-keys -t \{left\} -l '\"'{2}'\"' && \
           tmux send-keys -t \{left\} Enter]\""

# We depend on this in .vimrc too for file listing.
export FZF_DEFAULT_COMMAND="rg --files --follow --hidden --glob '!.git/*' --glob '!sorbet/**' --glob '!tags'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export GOPATH=$HOME

# export RUST_LOG=info
export RIPGREP_CONFIG_PATH="$HOME/.rgrc"

(ssh-add -l | grep -q "Error connecting to agent") && ssh-agent bash
(ssh-add -l | grep -q "no identities") && ssh-add -K

if [[ -f ~/.env ]]; then
  source ~/.env
fi

if [[ $(whoami) == 'personal' ]]; then
  source /usr/local/share/chruby/chruby.sh
fi

# cloudplatform: add Shopify clusters to your local kubernetes config
export KUBECONFIG=/Users/$(whoami)/.kube/config:/Users/$(whoami)/.kube/config.shopify.cloudplatform
for file in /Users/simoneskildsen/src/github.com/Shopify/cloudplatform/workflow-utils/*.bash; do source ${file}; done
kubectl-short-aliases

# load dev, but only if present and the shell is interactive
if [[ -f /opt/dev/dev.sh ]] && [[ $- == *i* ]]; then
  source /opt/dev/dev.sh
fi
