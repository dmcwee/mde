FROM ubuntu AS clone
RUN apt update
RUN apt install -y git jq curl dos2unix
RUN git clone https://github.com/microsoft/mdatp-xplat.git /mde

WORKDIR /mde/linux/definition_downloader
COPY settings.json .
COPY xplat_offline_updates_download.sh .
RUN dos2unix xplat_offline_updates_download.sh
RUN dos2unix settings.json
RUN ./xplat_offline_updates_download.sh

FROM nginx:stable-perl AS host
COPY --from=clone /mde/wdav-update /usr/share/nginx/html/