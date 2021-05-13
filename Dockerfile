FROM swift:latest as build

WORKDIR /build

COPY . .

RUN swift run

FROM nginx:alpine

RUN rm /usr/share/nginx/html/index.html

COPY --from=build /build/Output /usr/share/nginx/html
