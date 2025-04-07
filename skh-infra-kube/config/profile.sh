alias kubewatch="watch 'kubectl get pod -A -o wide ; kubectl version ; kubectl get nodes -o wide'"
## load fedora-kube infra vars
export $(grep -v '^#' /etc/kubernetes/fedora-kube.d/*.conf | cut -f2- -d':' | xargs)