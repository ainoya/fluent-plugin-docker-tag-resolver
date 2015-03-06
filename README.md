# fluent-plugin-docker-tag-resolver

## Overview

## Installation

Install with fluent-gem command as:

```
# for google-fluentd
$ /opt/google-fluentd/embedded/lib/ruby/gems/2.1.0/gems/fluent-plugin-docker-tag-resolver-0.1.0# /opt/google-fluentd/embedded/bin/gem install 
```

## Configuration

### Usage

It's a sample to exclude some static file log before split tag by domain.

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

## Reference

[fluent/fluent-plugin-rewrite-tag-filter](https://github.com/fluent/fluent-plugin-rewrite-tag-filter)

[Collecting Docker Log Files with Fluentd and sending to GCP.](https://github.com/GoogleCloudPlatform/kubernetes/tree/master/contrib/logging/fluentd-gcp-image)

## License

Apache License, Version 2.0

