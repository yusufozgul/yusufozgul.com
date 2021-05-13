FROM swift:slim as build

COPY Package.swift .
RUN swift package resolve
COPY . .

RUN swift run


FROM nginx:alpine
COPY Output/ /usr/share/nginx/html
