package service

import (
    "os"

    "github.com/docker/docker/client"
)

func NewDockerClientFromEnv() (*client.Client, error) {
    host := "unix:///var/run/docker.sock"
    if len(os.Getenv("DF_DOCKER_HOST")) > 0 {
        host = os.Getenv("DF_DOCKER_HOST")
    }

    cli, err := client.NewClientWithOpts(
        client.WithHost(host),
        client.FromEnv,
        client.WithAPIVersionNegotiation(),
    )
    if err != nil {
        return nil, err
    }

    return cli, nil
}

