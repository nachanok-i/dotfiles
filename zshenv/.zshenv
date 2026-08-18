# uv
export PATH="/Users/macbook/.local/bin:$PATH"

# mysql: the default `mysql` is v9, which dropped the mysql_native_password client plugin that the
# Azure SIT/UAT servers require (ERROR 2059 before the password is even sent). 8.4 still has it.
# Lives here, not .zshrc, so non-interactive shells and tooling get it too.
export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"
