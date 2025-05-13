FROM rockylinux:9

RUN dnf install -y cpio
RUN curl -o /usr/bin/apptainer-install-unprivileged https://raw.githubusercontent.com/apptainer/apptainer/main/tools/install-unprivileged.sh
RUN chmod +x /usr/bin/apptainer-install-unprivileged

ENTRYPOINT ["/usr/bin/apptainer-install-unprivileged"]
