ARG PROJECT_ID
ARG FLUTTER_CHANNEL
ARG BUILD_SHA

FROM gcr.io/$PROJECT_ID/flutter:$FLUTTER_CHANNEL

WORKDIR /pkgs/dartpad_shared
COPY pkgs/dartpad_shared .

WORKDIR /pkgs/dart_services
COPY pkgs/dart_services .

RUN dart pub get
RUN dart compile exe bin/server.dart -o bin/dart_services

RUN dart run grinder build-project-templates

ENV BUILD_SHA=$BUILD_SHA

EXPOSE 8081
CMD ["/app/bin/dart_services"]
