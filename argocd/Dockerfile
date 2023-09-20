
#--------------------------------------------#
#--------Build KSOPS and Kustomize-----------#
#--------------------------------------------#

FROM quay.io/simbelmas/argocd:dockerio-ksops-latest-mirror@sha256:c12a11ec7a51498e42e0b71656d857cf80c0fcf11ce189e7ce69624b3b173813 as ksops-builder

#--------------------------------------------#
#--------Build Custom Argo Image-------------#
#--------------------------------------------#

FROM quay.io/argoproj/argocd:v2.8.4@sha256:f02d31d4b115d79de3dc45ebeec3a3107b9178d980e69d9dc2b26019d43f3e09 as argocd

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