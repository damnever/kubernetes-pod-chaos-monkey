# Kubernetes Pod Chaos Monkey

This repository contains a `Dockerfile` and associated Kubernetes configuration for a Deployment that will randomly delete pods in a given namespace. This is implemented in Bash mostly because I'm writing it for a lightning talk.

~An image built from the `Dockerfile` in this repository is available on Docker Hub as [`jnewland/kubernetes-pod-chaos-monkey`](https://hub.docker.com/r/jnewland/kubernetes-pod-chaos-monkey/).~

### Configuration

A few environment variables are available for configuration:

* `MIN_DELAY_IN_SECS`: minimum seconds between selecting and deleting a pod. Defaults to `30`.
* `MAX_DELAY_IN_SECS`: maximum seconds between selecting and deleting a pod. Defaults to `90`.
* `NAMESPACE`: the namespace to select a pod from. Defaults to `default`.
* `EXCLUDED_POD_PREFIX`: specifies the prefix used to exclude pods. Defaults to `NONE`.

Example Kubernetes config is included at [`config/kubernetes/production/deployment.yaml`](./config/kubernetes/production/deployment.yaml)

### Example

```bash
$ kubectl apply -f config/kubernetes/production/deployment.yaml
deployment "kubernetes-pod-chaos-monkey" created
$ kubectl get pods | grep chaos
kubernetes-pod-chaos-monkey-3294408070-6w6oh   1/1       Running       0          19s
$ kubectl logs kubernetes-pod-chaos-monkey-3294408070-6w6oh
MIN_DELAY_IN_SECS=300
MAX_DELAY_IN_SECS=600
NAMESPACE=test
[2022/08/03 10:25:11] pod "foo-7ddc6dd94f-4xx7q" deleted
[2022/08/03 10:30:38] pod "bar-55775f8fc8-fwqnp" deleted
```

## License

[MIT](./LICENSE.md)
