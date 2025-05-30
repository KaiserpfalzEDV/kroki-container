# Starte mit dem offiziellen Kroki-Image
FROM docker.io/yuzutech/kroki:latest

USER 0
# Installiere git, um die stdlib zu klonen
RUN apt-get update && apt-get install -y git \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Klone die komplette PlantUML stdlib
RUN git clone https://github.com/plantuml/plantuml-stdlib.git /usr/local/plantuml-stdlib \
 && mv /usr/local/plantuml-stdlib/stdlib /usr/local/stdlib \
 && rm -rf /usr/local/plantuml-stdlib \
 && mv /usr/local/stdlib /usr/local/plantuml-stdlib

# Setze die PLANTUML_INCLUDE-Umgebungsvariable, um Kroki PlantUML mitzuteilen, wo die stdlib ist
ENV KROKI_PLANTUML_INCLUDE_PATH="/usr/local/plantuml-stdlib"
ENV KROKI_PLANTUML_ALLOW_INCLUDE="true"

USER 1000
# (Optional) Exponiere den Kroki-Port
#EXPOSE 8000

# Starte Kroki
#CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/opt/kroki/kroki.jar"]