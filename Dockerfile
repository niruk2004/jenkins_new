FROM jenkins/jenkins:2.504.2-jdk21

USER root

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
        lsb-release \
        python3 \
        python3-pip \
        python3-venv \
        curl && \
    apt-get clean

# Add Docker repo and install Docker CLI
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y docker-ce-cli

# Switch back to Jenkins user
# USER jenkins

# Install Jenkins plugins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow json-path-api"

# This gives you:
#     Python 
#     pip 
#     venv
#     Docker CLI 
#     Jenkins plugins
