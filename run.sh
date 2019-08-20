#!/bin/sh

helm="$WERCKER_STEP_ROOT/helm"

main() {
    display_version

    if [ -z "$WERCKER_HELM_COMMAND" ]; then
        fail "helm: command argument cannot be empty"
    fi

    if [ -z "$WERCKER_HELM_TOKEN" ]; then
        fail "helm: token argument cannot be empty"
    fi

    if [ -z "$WERCKER_HELM_SERVER" ]; then
        fail "helm: server argument cannot be empty"
    fi

    cmd="$WERCKER_HELM_COMMAND"
    
    # Create a temporary kube.config file using the Token and Server
    cat <<EOF > kube.config
          apiVersion: v1
          clusters:
          - cluster:
              insecure-skip-tls-verify: true
              server: $WERCKER_HELM_SERVER
            name: cluster
          contexts:
          - context:
              cluster: cluster
              user: user
            name: cluster
          current-context: cluster
          kind: Config
          preferences: {}
          users:
          - name: user
            user:
              token: $WERCKER_HELM_TOKEN
EOF
    eval "$helm" --kubeconfig kube.config "$cmd"
}

display_version() {
  info "Running Helm version:"
  "$helm" version --client
  echo ""
}

main;