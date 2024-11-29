ARG PYTHON_VERSION=python:3.12
ARG OPENJDK_VERSION=openjdk:8-slim-buster
ARG APP_SERVER_PORT=8080
# python
FROM $PYTHON_VERSION AS py3
ENV PYTHONUNBUFFERED 1

# java
FROM $OPENJDK_VERSION
COPY --from=py3 / /

# copy the code files
WORKDIR /app
COPY src /app/src
COPY webapp /app/webapp
COPY config /app/config
COPY requirements.txt .
COPY setup.py .
COPY README.md .

# Build the environnement
RUN pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# TODO; rechck the is package for th model architechutre plot
RUN apt install graphviz

EXPOSE $APP_SERVER_PORT
CMD ["python", "main.py"]