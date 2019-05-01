# micronaut-getting-started

Result of the [Getting Started with Micronaut and Graal](https://docs.micronaut.io/latest/guide/index.html#graal) - 
slightly extended so 

* a GraalVM native image can be built using a "self-contained" `Dockerfile` that does not require to build or install 
  anything locally and
* to be compiled statically so a minimal (`scratch`) docker base image can be used.

To build just run

```bash
docker build -t micronaut/getting-started .
```

Then start the container with

```
docker run -i --rm -p 8080:8080 micronaut/getting-started
```

## Base images compared

As of May 2019, the Micronaut getting started uses the `frolvlad/alpine-glibc` base image for the final image. 
This repo provides a couple of other base images that compare as follows

| Base Image | Size | Shell | Package Manager | libc | Basic Linux Folders | Static Binary | `Dockerfile` | 
|---|---|---|---|---| ---| ---| ---|
| alpine-glibc | [![](https://images.microbadger.com/badges/image/schnatterer/micronaut-getting-started:alpine-glibc.svg)](https://hub.docker.com/r/schnatterer/micronaut-getting-started/tags) | ☒ | ☒ | ☒ | ☒ | ☐ | [📄](https://github.com/schnatterer/micronaut-getting-started/blob/c93b115f6a922c50679b0396f194bb216cc70dfa/Dockerfile) | 
| distroless-static | [![](https://images.microbadger.com/badges/image/schnatterer/micronaut-getting-started:distroless-static.svg)](https://hub.docker.com/r/schnatterer/micronaut-getting-started/tags) | ☐ | ☐ | ☐ | ☒ | ☒ | [📄](https://github.com/schnatterer/micronaut-getting-started/blob/94ecbadfb0d0148072aa30eae25539527b9d1ddd/Dockerfile) |
| scratch | [![](https://images.microbadger.com/badges/image/schnatterer/micronaut-getting-started:scratch.svg)](https://hub.docker.com/r/schnatterer/micronaut-getting-started/tags) | ☐ | ☐ | ☐ | ☐ | ☒ | [📄](https://github.com/schnatterer/micronaut-getting-started/blob/4bad7444bd5f301351fa5df67d706de222764ea2/Dockerfile) |

Note that 

* size is the compressed size within the DockerHub registry,
* if a shell is needed for debugging, you could just copy a statically compiled shell into the container, 
  (except, of course, you're using a read-only filesystem):
  
```bash
docker run --rm --name micronaut-getting-started schnatterer/micronaut-getting-started

docker create --name busybox busybox
docker cp busybox:/bin/busybox busybox
docker cp busybox micronaut-getting-started:/busybox
docker exec -it micronaut-getting-started /busybox sh
```