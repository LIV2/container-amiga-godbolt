# Amiga-Godbolt Docker Container

This repository provides a Docker container for running the Godbolt Compiler Explorer configured with `amiga-gcc`, enabling compilation and exploration of Amiga-specific C/C++ code in a web-based interface.

## Overview

The container is pre-configured with the Godbolt Compiler Explorer and the `amiga-gcc` toolchain, allowing developers to write, compile, and analyze Amiga code directly from a browser. The web interface is accessible via an exposed port (default: 10240).

## Getting Started

### Prerequisites

- Docker installed on your system.

### Pulling the Image

The Docker image is available on DockerHub. Pull the latest version using:

```bash
docker pull liv2/amiga-godbolt:latest
```

### Running the Container

To start the container and access the Compiler Explorer web interface, run:

```bash
docker run -p 10240:10240 liv2/amiga-godbolt:latest
```

This command maps port 10240 on your host machine to the container's exposed port. Once the container is running, open your browser and navigate to:

```
http://localhost:10240
```

### Custom Port Mapping

If you need to use a different host port, you can specify it in the `docker run` command. For example, to map the container's port 10240 to port 8080 on your host:

```bash
docker run -p 8080:10240 liv2/amiga-godbolt:latest
```

Then access the web interface at:

```
http://localhost:8080
```

## Usage

- **Web Interface**: The Compiler Explorer provides a split-screen interface where you can write C/C++ code, compile it with `amiga-gcc`, and view the generated assembly output.
- **Amiga-Specific Development**: The container is tailored for Amiga development, supporting the `amiga-gcc` toolchain for compiling code targeting Amiga systems.

## Contributing

Contributions are welcome! If you encounter issues or have suggestions for improvements, please:

1. Open an issue on the [GitHub repository](https://github.com/LIV2/container-amiga-godbolt).
2. Submit a pull request with your proposed changes.

## License

[![License: GPL v2](https://img.shields.io/badge/License-GPL_v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

This project is licensed under the GPL-2.0 only license

## Contact

For questions or support, please open an issue on the [GitHub repository](https://github.com/LIV2/container-amiga-godbolt).