# ============================================================
#  CodeX Sandbox — safe code testing environment
#  Build: docker build -t sandbox .
#  Run:   docker run -it --rm --network none -v $(pwd):/work sandbox
# ============================================================

FROM ubuntu:24.04

# --- Base tools ---
RUN apt update && apt install -y \
    python3 \
    python3-pip \
    curl \
    git \
    vim \
    netcat-openbsd \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# --- Working directory ---
WORKDIR /work

# --- Default shell ---
CMD ["/bin/bash"]