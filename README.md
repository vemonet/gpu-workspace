# 💡 Containerized GPU Workspace

[![Build and publish docker image](https://github.com/vemonet/gpu-workspace/actions/workflows/build.yml/badge.svg)](https://github.com/vemonet/gpu-workspace/actions/workflows/build.yml)

This Docker image provides a lightweight and ready-to-use containerized environment for remote development on GPU servers, complete with the [Nvidia CUDA toolkit](https://developer.nvidia.com/cuda-toolkit). It is ideal for anyone looking to leverage GPU resources for computing tasks, machine learning, or data processing.

## 🚀 Usage

### 1. 🐳 Start the container

**Using docker compose:**

Refer to the `docker-compose.yml` file for a complete deployment configuration with GPU access. Start the container with:

```bash
docker compose up
```

**Using docker run:**

Alternatively, you can start the container directly using the docker command:

```bash
docker run --rm -it --name gpu-workspace --gpus all -v $(pwd):/app ghcr.io/vemonet/gpu-workspace:latest
```

### 2. 🔌 Connect to the container

Connect to the container on the remote server using Visual Studio Code extensions (or any other IDE that supports remote connections):

* [Remote Explorer](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-explorer)
* [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)
* [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

> [!NOTE]
>
> For detailed instructions, see the [Microsoft Docs on Developing on a remote Docker host](https://code.visualstudio.com/remote/advancedcontainers/develop-remote-host).

> [!TIP]
>
> Create a SSH configuration file at `~/.ssh/config` in your home directory for an easy server connection via the **Remote Explorer** extension.
>
> ```bash
> host g1
>   hostname g1.url.to.server.com
>   user username_on_server
> ```

## 🔋 Features

🐍 **Python 3.10** with `pip` and [`hatch`](https://hatch.pypa.io/latest/), for python development.

🧑‍💻 **ZSH** for an efficient terminal experience with Oh My ZSH.

⚡ **CUDA** toolkit pre-installed for immediate GPU computing. Use `nvidia-smi` in the terminal inside the container to monitor GPU utilization.

📂 Use the **`/app` folder** inside the container to mount your codebase and data as volume.

## 📦 Build

The published image uses [`nvcr.io/nvidia/cuda:12.1.0-runtime-ubuntu22.04`](https://ngc.nvidia.com/catalog/containers/nvidia:cuda) as base image (2.7G):

```bash
docker build --build-arg BASE_IMAGE=nvcr.io/nvidia/cuda:12.1.0-runtime-ubuntu22.04 -t ghcr.io/vemonet/gpu-workspace:latest .
docker run --rm -it --name gpu-workspace ghcr.io/vemonet/gpu-workspace:latest
```

You should be able to use other debian-based Nvidia images as base, such as [`nvcr.io/nvidia/pytorch:23.06-py3`](https://ngc.nvidia.com/catalog/containers/nvidia:pytorch) (8.5G):

```bash
docker build --build-arg BASE_IMAGE=nvcr.io/nvidia/pytorch:23.06-py3 -t ghcr.io/vemonet/gpu-workspace:pytorch .
```

> [!TIP]
>
> Check the size of your built image (in MB) with:
>
> ```bash
> expr $(docker image inspect ghcr.io/vemonet/gpu-workspace:latest --format='{{.Size}}') / 1000000
> ```

## 🕊️ Contributions welcome

Feel free to share your ideas, feedback, and code improvements through issues or PRs – they all are greatly appreciated!
