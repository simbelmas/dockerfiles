
#--------------------------------------------#
#--------Build KSOPS and Kustomize-----------#
#--------------------------------------------#

FROM quay.io/simbelmas/argocd:dockerio-ksops-latest-mirror@sha256:c3b89fca8a0724b88ad73d36c548c7cb787619b3d49679f11679baf0a1fbf9c6 as ksops-builder

#--------------------------------------------#
#--------Build Custom Argo Image-------------#
#--------------------------------------------#

FROM quay.io/argoproj/argocd:v2.6.7@sha256:a9a0c6b9360587d9786c0d84b0bf948d97a67cd3a2e9b669c1aa06c348a2bd09 as argocd

# Switch to root for the ability to perform install
USER root

# Set the kustomize home directory
ENV XDG_CONFIG_HOME=$HOME/.config
ENV KUSTOMIZE_PLUGIN_PATH=$XDG_CONFIG_HOME/kustomize/plugin/

ARG PKG_NAME=ksops

# Override the default kustomize executable with the Go built version
COPY --from=ksops-builder /go/bin/kustomize /usr/local/bin/kustomize

# Copy the plugin to kustomize plugin path
COPY --from=ksops-builder /go/src/github.com/viaduct-ai/kustomize-sops/*  $KUSTOMIZE_PLUGIN_PATH/viaduct.ai/v1/${PKG_NAME}/

# Switch back to non-root user
USER 999