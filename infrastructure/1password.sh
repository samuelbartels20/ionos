
#!/usr/bin/env bash

set -e

# Eval so we can set the JSON values as shell variables
eval "$(jq -r '@sh "VAULT=\(.vault) UUID=\(.uuid)"')"

# Get the token or password from the first field of the second section (this is just how I store them, but you could use jq's select
password=`op get item --vault=$VAULT $UUID | jq -r '.details.sections[1].fields[0].v'`

if [ -z "$password" ]; then
  # I didn't get a token, so let's bail
  echo "No token returned. Did you run 'op signin company-one-pass'?"
  exit 1
fi

# Use JQ to put args into a JSON string we return to STDOUT
jq -n --arg token "$password" '{"password":$password}'