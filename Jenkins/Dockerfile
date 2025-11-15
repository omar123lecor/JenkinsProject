FROM jenkins/jenkins:lts

USER root

# Install Docker CLI ONLY (not docker engine)
RUN apt-get update && \
    apt-get install -y docker.io && \
    rm -rf /var/lib/apt/lists/*

# Give Jenkins access to host docker
RUN usermod -aG docker jenkins

USER jenkins
