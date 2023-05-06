FROM debian:stable-slim

# download the install_quarto.sh script from rocker-org/versioned2 repo
ADD https://raw.githubusercontent.com/rocker-org/rocker-versioned2/75dd95c6cee7da29ceed363b9fe4823a12f575f8/scripts/install_quarto.sh /tmp/install_quarto.sh
RUN chmod +x /tmp/install_quarto.sh \
    && /tmp/install_quarto.sh 1.3.340
