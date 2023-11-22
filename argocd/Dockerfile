
#--------------------------------------------#
#--------Build KSOPS and Kustomize-----------#
#--------------------------------------------#

FROM quay.io/simbelmas/argocd:dockerio-ksops-latest-mirror@sha256:c12a11ec7a51498e42e0b71656d857cf80c0fcf11ce189e7ce69624b3b173813 as ksops-builder

#--------------------------------------------#
#--------Build Custom Argo Image-------------#
#--------------------------------------------#

FROM quay.io/argoproj/argocd:v2.9.2@sha256:8576d347f30fa4c56a0129d1c0a0f5ed1e75662f0499f1ed7e917c405fd909dc as argocd

# Switch to root for the ability to perform install
USER root

# Set the kustomize home directory
ENV XDG_CONFIG_HOME=$HOME/.config
ENV KUSTOMIZE_PLUGIN_PATH=$XDG_CONFIG_HOME/kustomize/plugin/

ARG PKG_NAME=ksops

# Override the default kustomize executable with the Go built version
COPY --from=ksops-builder /go/bin/kustomize /usr/local/bin/kustomize

# Copy the plugin to kustomize plugin path
COPY --from=ksops-builder /go/bin/ksops  $KUSTOMIZE_PLUGIN_PATH/viaduct.ai/v1/${PKG_NAME}/
COPY --from=ksops-builder /go/bin/kustomize-sops  $KUSTOMIZE_PLUGIN_PATH/viaduct.ai/v1/${PKG_NAME}/


# Switch back to non-root user
USER 999