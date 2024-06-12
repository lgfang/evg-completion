# Auto-completion for the evergreen CLI command

## Prerequisites

It uses fzf, hence please ensure fzf is installed.

## Installation

If you use bash, download `evergreen_completion.bash` into
`$HOME/.bash_completion.d` and then ensure the following is in your
`$HOME/.bashrc`:

```shell
if [ -d "$HOME/.bash_completion.d" ]; then
    for each in $HOME/.bash_completion.d/*; do
        source "$each"
    done
fi
```
