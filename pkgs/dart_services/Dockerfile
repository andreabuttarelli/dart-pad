FROM dart:stable AS build

WORKDIR /app

COPY . .

RUN dart pub global activate dart_frog_cli
RUN dart pub global run dart_frog_cli:dart_frog build

RUN dart compile exe build/bin/dart_services.dart -o build/bin/server

RUN dart run grinder build-project-templates

FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/build/bin/server /app/bin/

EXPOSE 8081
CMD ["/app/bin/server"]
