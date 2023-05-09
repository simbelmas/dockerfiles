
#--------------------------------------------#
#--------Build KSOPS and Kustomize-----------#
#--------------------------------------------#

FROM quay.io/simbelmas/argocd:dockerio-ksops-latest-mirror@sha256:1707bd0f84124680cb17927f13b3b1c34f6aa9f07e0a6a6705980aaab75995f4 as ksops-builder

#--------------------------------------------#
#--------Build Custom Argo Image-------------#
#--------------------------------------------#

FROM quay.io/argoproj/argocd:v2.7.1@sha256:cf9ef408e423635f30dee3c57f06ef011ce7bb9a7110041badd278b93ae86b85 as argocd

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