# fluent-plugin-docker-tag-resolver [![Gem Version](https://badge.fury.io/rb/fluent-plugin-docker-tag-resolver.svg)](http://badge.fury.io/rb/fluent-plugin-docker-tag-resolver)

## Overview

This plugin finds the docker container name and its image name from container-id in record tag,
and rewrite container-id to human-readable tag name.

It's focused on collecting docker container logs from `/var/lib/docker/containrs/*/*-json.log`.

For example, the plugin rewrites the tags like below:

Before:

```
"docker.log.var.lib.docker.containers.695e035397f1d5c6cd88225dab54afaed170b93c3ebf51e4354c4daf796e6017.695e035397f1d5c6cd88225dab54afaed170b93c3ebf51e4354c4daf796e6017-json.log"
```

After:

```
#The tags represented with docker.container.#{image_name}.#{container_name}.#{container_id}

docker.container.kubernetes/fluentd-gcp:1.0.backstabbing_yonath.695e035397f1d5c6cd88225dab54afaed170b93c3ebf51e4354c4daf796e6017
```


## Installation

Install with fluent-gem command as:

```
# for google-fluentd
$ /opt/google-fluentd/embedded/bin/gem install fluent-plugin-docker-tag-resolver
```

## Configuration

### Usage


```
<source>
  type tail
  format none
  time_key time
  path /var/lib/docker/containers/*/*-json.log
  pos_file /var/lib/docker/containers/containers.log.pos
  time_format %Y-%m-%dT%H:%M:%S
  tag docker.log.*
</source>

<match docker.log.**>
  type docker_tag_resolver
</match>

<match docker.container.**>
  type stdout
</match>

```

### Result

```
2015-03-06 08:09:34 +0000 docker.container.kubernetes/fluentd-gcp:1.0.backstabbing_yonath.695e035397f1d5c6cd88225dab54afaed170b93c3ebf51e4354c4daf796e6017: {"message":"{\"log\":\"\\u001b(B\\u001b[m  349 root      20   0   91208  23124   6888 S   0.0  1.1   0:00.21 google-fluentd                                                                  \\u001b(B\\u001b[m\\u001b[39;49m\\u001b[K\\r\\n\",\"stream\":\"stdout\",\"time\":\"2015-03-06T08:09:34.980863575Z\"}"}
2015-03-06 08:09:34 +0000 docker.container.kubernetes/fluentd-gcp:1.0.backstabbing_yonath.695e035397f1d5c6cd88225dab54afaed170b93c3ebf51e4354c4daf796e6017: {"message":"{\"log\":\"\\u001b(B\\u001b[m  355 root      20   0    4388    680    604 S   0.0  0.0   0:00.01 tail                                                                            \\u001b(B\\u001b[m\\u001b[39;49m\\u001b[K\\r\\n\",\"stream\":\"stdout\",\"time\":\"2015-03-06T08:09:34.980863575Z\"}"}
2015-03-06 08:09:34 +0000 docker.container.kubernetes/fluentd-gcp:1.0.backstabbing_yonath.695e035397f1d5c6cd88225dab54afaed170b93c3ebf51e4354c4daf796e6017: {"message":"{\"log\":\"\\u001b(B\\u001b[m\\u001b[1m  356 root      20   0   19872   2516   2176 R   0.0  0.1   0:00.01 top                                                                             \\u001b(B\\u001b[m\\u001b[39;49m\\u001b[K\\r\\n\",\"stream\":\"stdout\",\"time\":\"2015-03-06T08:09:34.980863575Z\"}"}
2015-03-06 08:09:37 +0000 docker.container.kubernetes/fluentd-gcp:1.0.backstabbing_yonath.695e035397f1d5c6cd88225dab54afaed170b93c3ebf51e4354c4daf796e6017: {"message":"{\"log\":\"\\u001b[J\\u001b[?1l\\u001b\\u003e\\u001b[31;1H\\r\\n\",\"stream\":\"stdout\",\"time\":\"2015-03-06T08:09:37.507569483Z\"}"}
```

## Use case

Here, the configuration to collect all docker logs inside the kubernetes world with fluentd.

### Build google-fluentd image includes `fluent-plugin-docker-tag-resolver`

```
cd docker
make build
```

### Fleet service definition

```
[Unit]
Description=Google-Fluentd Agent Service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker kill td-agent
ExecStartPre=-/usr/bin/docker rm td-agent
ExecStartPre=-/usr/bin/docker pull registry.yourprivate.jp/fluentd-gcp:1.0
ExecStart=/usr/bin/bash -c \
"/usr/bin/docker run --privileged --name td-agent \
-v /var/lib/docker:/var/lib/docker -v /var/run/docker.sock:/var/run/docker.sock \
registry.yourprivate.jp/fluentd-gcp:1.0"

[X-Fleet]
Global=true
```

## Reference

[fluent/fluent-plugin-rewrite-tag-filter](https://github.com/fluent/fluent-plugin-rewrite-tag-filter)

[Collecting Docker Log Files with Fluentd and sending to GCP.](https://github.com/GoogleCloudPlatform/kubernetes/tree/master/contrib/logging/fluentd-gcp-image)

## License

Apache License, Version 2.0

