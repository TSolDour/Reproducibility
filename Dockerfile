#Faire démarrer l'image depuis l'image rocker/r-ver:4.5.2
FROM rocker/r-ver:4.5.2

# Créer le dossier project dans le container (tout se passera là)
WORKDIR /project

# Mettre à jour les paquets linux disponibles et installer libuv1 et les bibliothèques nécessaires à curl
RUN apt-get update && apt-get install -y \
    curl \
    pandoc \
    libuv1 \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libwebp-dev \
    libcairo2-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libglpk-dev \
    && rm -rf /var/lib/apt/lists/*

# Installer le Quarto CLI nécessaire pour faire tourner le package quarto
ARG QUARTO_VERSION=1.10.18

RUN curl -Ls "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz" -o quarto.tar.gz \
    && mkdir -p /opt/quarto \
    && tar -xzf quarto.tar.gz -C /opt/quarto --strip-components=1 \
    && ln -s /opt/quarto/bin/quarto /usr/local/bin/quarto \
    && rm quarto.tar.gz

# Pendant la construction de l'image, lancer R et exécuter le code suivant
RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"

# Copier les fichiers nécessaires à renv::restore() depuis le projet local  vers le container
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

# Pendant la construction de l'image, lancer R et exécuter le code suivant : restore la librairie renv du projet
RUN R -e "renv::restore()"

# Une fois que l'environnement est ok, copier tout le projet
COPY . .

# Spécifier où targets doit trouver son script
ENV TAR_PROJECT=reproducibility

# Exécuter le pipeline targets dans l'image
RUN R -e "targets::tar_make()"

# Exécuter le pipeline au lancement du container
CMD ["R", "-e", "targets::tar_make()"]

