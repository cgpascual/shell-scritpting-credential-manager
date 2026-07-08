FROM bash:latest

WORKDIR /app

COPY credential_manager.sh .

RUN chmod +x credential_manager.sh

ENTRYPOINT ["bash", "./credential_manager.sh"]