FROM ubuntu:focal AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible vim build-essential sudo && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS alex
RUN groupadd -f alex
RUN useradd \
  --create-home \
  --gid alex \
  --groups sudo \
  --shell /bin/bash \
  --password $(echo "alex" | openssl passwd -1 -stdin) \
  alex
RUN usermod -aG sudo alex
USER alex
WORKDIR /home/alex

FROM alex
COPY --chown=alex:alex . .
CMD ["ansible-playbook", "main.yml", "--extra-vars", "ansible_become_password='alex'"]

