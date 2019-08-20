# Helm

This step vendor the Helm executable and allows users to execute Helm commands.

# Options
* `command` - The Helm command whichs needs to be run
* `token` - User token value from the kube.config file
* `server` - Server URL fro mthe kube.config file

Note: step creates a temporary kube.config file that gets passed to the Helm command. The `insecure-skip-tls-verify` is set to true.

# Example

```
deploy:
    steps:
        - pjausovec/helm:
            server: $KUBERNETES_SERVER
            token: $KUBERNETES_USER_TOKEN
            command: upgrade myrelease 
```