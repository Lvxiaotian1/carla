FROM carla-prerequisites:latest

ARG GIT_BRANCH

USER carla
WORKDIR /home/carla

RUN cd /home/carla/ && \
  if [ -z ${GIT_BRANCH+x} ]; then git clone --depth 1 http://github.fishros.org/https://github.com/carla-simulator/carla.git; \
  else git clone --depth 1 --branch $GIT_BRANCH http://github.fishros.org/https://github.com/carla-simulator/carla.git; fi && \
  cd /home/carla/carla && \
  ./Update.sh && \
  make CarlaUE4Editor && \
  make PythonAPI && \
  make build.utils && \
  make package && \
  rm -r /home/carla/carla/Dist

WORKDIR /home/carla/carla
