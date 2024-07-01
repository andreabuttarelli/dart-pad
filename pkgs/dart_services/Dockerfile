FROM ubuntu:20.04

# Installa le dipendenze
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    xz-utils \
    libglu1-mesa \
    pkg-config

# Clona Flutter o aggiorna se già presente
RUN if [ -d "flutter" ]; then \
        cd flutter && git pull && cd ..; \
    else \
        git clone https://github.com/flutter/flutter.git -b stable; \
    fi

# Configura Flutter
RUN /app/flutter/bin/flutter config --disable-analytics

# Imposta le variabili d'ambiente
ENV FLUTTER_ROOT=/app/flutter
ENV PATH=$PATH:/app/flutter/bin

RUN flutter/bin/dart pub get
RUN flutter/bin/dart compile exe bin/dart_services.dart -o bin/dart_services

RUN flutter/bin/dart run grinder build-project-templates

EXPOSE 8081
CMD ["/app/bin/dart_services"]
