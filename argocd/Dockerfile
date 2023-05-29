
#--------------------------------------------#
#--------Build KSOPS and Kustomize-----------#
#--------------------------------------------#

FROM quay.io/simbelmas/argocd:dockerio-ksops-latest-mirror@sha256:55d4d4f8986419bd7f591643175c3d8bd064d3de72ff5678bd81311ee157b60a as ksops-builder

#--------------------------------------------#
#--------Build Custom Argo Image-------------#
#--------------------------------------------#

FROM quay.io/argoproj/argocd:v2.7.2@sha256:9b867d3175815d6d253dbc817bb7da34a3ba49a99ffade9a36cad238cf78963e as argocd

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