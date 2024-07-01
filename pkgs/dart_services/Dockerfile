FROM dart:stable AS build

WORKDIR /app

COPY . .

RUN dart compile exe bin/dart_services.dart -o bin/server

RUN dart run grinder build-project-templates

FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/build/bin/server /app/bin/

EXPOSE 8081
CMD ["/app/bin/server"]
