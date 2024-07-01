FROM debian:bullseye-slim

# Install Dependencies.
RUN apt update -y
RUN apt install -y git wget curl unzip lib32stdc++6 libglu1-mesa default-jdk-headless

# Install Flutter.
ENV FLUTTER_ROOT="/opt/flutter"
RUN git clone https://github.com/flutter/flutter "${FLUTTER_ROOT}"
ENV PATH="${FLUTTER_ROOT}/bin:${PATH}"

# Disable analytics and crash reporting on the builder.
RUN flutter config --no-analytics

# Perform an artifact precache so that no extra assets need to be downloaded on demand.
RUN flutter precache
# Perform a doctor run.
RUN flutter doctor -v
# Switch to the correct channel
ARG channel=stable
RUN flutter channel $channel
# Perform a flutter upgrade
RUN flutter upgrade

WORKDIR /app

# Copy the project files into the container
COPY pkgs/dartpad_shared /app/pkgs/dartpad_shared
COPY pkgs/dart_services /app/pkgs/dart_services

# Change to the dart_services directory
WORKDIR /app/pkgs/dart_services

RUN ls

# Install dependencies
RUN flutter pub get

# Verify that dart is available
RUN which dart

RUN dart --version

RUN dart compile exe bin/dart_services.dart

RUN dart run grinder build-project-templates

EXPOSE 8081
CMD ["./bin/dart_services"]
