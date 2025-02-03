# Use Debian bookworm as the base image
FROM debian:bookworm

# Install wget and git (required for Miniconda and cloning)
RUN apt-get update && apt-get install -y wget git

# Download and install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/miniconda && \
    rm /tmp/miniconda.sh

# Add Miniconda to PATH
ENV PATH="/opt/miniconda/bin:$PATH"

# Clone the specified repository into the root directory
RUN git clone https://github.com/dbarnett/python-helloworld.git /python-helloworld

# Set working directory to the cloned repository
WORKDIR /python-helloworld

# Ensure dependencies are installed (if needed)
RUN /opt/miniconda/bin/pip install -r requirements.txt || true

# Run the script & keep container alive
CMD ["/bin/bash", "-c", "/opt/miniconda/bin/python /python-helloworld/helloworld.py && tail -f /dev/null"]
