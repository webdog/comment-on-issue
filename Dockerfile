FROM python:3-stretch

LABEL name="issue commenter"
LABEL version="0.0.1"
LABEL repository="https://github.com/webdog/comment-on-issue"
LABEL homepage="https://github.com/webdog/comment-on-issue"

LABEL maintainer="Christian Weber"
LABEL com.github.actions.name="Comment on Issues with a GitHub Action"
LABEL com.github.actions.description="The name is self explanatory"
LABEL com.github.actions.icon="box"
LABEL com.github.actions.color="green"
COPY LICENSE README.md /

ENV DOCKERVERSION=18.06.1-ce
RUN apt-get update && \
  apt-get install -y --no-install-recommends curl groff jq && \
  apt-get -y clean && apt-get -y autoclean && apt-get -y autoremove && \
  curl -fsSLO https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 && \
  mv heptio-authenticator-aws_0.3.0_linux_amd64 /usr/local/bin/aws-iam-authenticator && \
  chmod +x /usr/local/bin/aws-iam-authenticator && \
  curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz && \
  tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker && \
  rm docker-${DOCKERVERSION}.tgz && \
  rm -rf /var/lib/apt/lists/* && \
  pip install --upgrade pip && \
  pip install setuptools github3.py

COPY "entrypoint.py" "/entrypoint.py"
ENTRYPOINT ["/entrypoint.py"]