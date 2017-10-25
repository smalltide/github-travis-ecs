#!/usr/bin/env sh

# Exit the script as soon as something fails.
set -e

# Execute the CMD from the Dockerfile and pass in all of its arguments.
exec "$@"