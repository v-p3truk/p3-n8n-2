# Stage 1: Static ffmpeg/ffprobe (no external dependencies)
FROM mwader/static-ffmpeg:7.1 AS ffmpeg

# Stage 2: Static curl (no external dependencies)
FROM ghcr.io/tarampampam/curl:latest AS curl

# Stage 3: n8n with tools
FROM docker.n8n.io/n8nio/n8n:2.8.1
USER root
COPY --from=ffmpeg /ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg /ffprobe /usr/local/bin/ffprobe
COPY --from=curl /bin/curl /usr/local/bin/curl
RUN chown -R node:node /home/node/.n8n
USER node
