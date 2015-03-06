# Collecting Docker Log Files with Fluentd and sending to GCP.
This directory contains the source files needed to make a Docker image
that collects Docker container log files using [Fluentd](http://www.fluentd.org/)
and sends them to GCP.
This image is designed to be used as part of the [Kubernetes](https://github.com/GoogleCloudPlatform/kubernetes)
cluster bring up process. The image resides at DockerHub under the name
[kubernetes/fluentd-gcp](https://registry.hub.docker.com/u/kubernetes/fluentd-gcp/).

# License

NOTE: This directory has been copied from [GoogleCloudPlatform/kubernetes/contrib/logging/fluentd-gcp-image][gcp] .

[https://github.com/GoogleCloudPlatform/kubernetes/tree/master/contrib/logging/fluentd-gcp-image]: [gcp]

