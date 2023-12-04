FROM quay.io/simbelmas/photoprism:dockerio-latest

USER 1000

## Default configuration since variables are already defined and override  defaults config file
env PHOTOPRISM_DISABLE_VECTORS=false
env PHOTOPRISM_DISABLE_TLS=true
env PHOTOPRISM_DEFAULT_TLS=false
env PHOTOPRISM_CONFIG_PATH=/photoprism/storage/config
env PHOTOPRISM_CACHE_PATH=/photoprism/storage/cache