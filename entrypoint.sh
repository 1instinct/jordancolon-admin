#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

echo Micro Kubernetes Container Startup
echo RAILS_ENV=$RAILS_ENV

if [ ! -e assets_precompiled ] ; then
    rails assets:precompile
    touch assets_precompiled
    # for the k8 deploy, we run this initially to build the assets and
    # then store the container so it can be scaled.  For normal
    # operation, this should not exist here but continue on to
    # start the web server.  TODO: there might be a better way to
    # do this.
    exit 0
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
