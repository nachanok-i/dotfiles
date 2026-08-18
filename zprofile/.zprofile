
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# Must come after brew shellenv: it prepends /opt/homebrew/bin, which holds the v9 `mysql` that
# dropped the mysql_native_password client plugin the Azure SIT/UAT servers require (ERROR 2059).
# .zshenv sets this too, for the non-login shells where brew shellenv never runs.
export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"
