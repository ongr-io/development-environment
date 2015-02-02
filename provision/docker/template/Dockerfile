#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM dockerfile/java

# Install ElasticSearch.
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-versions.tar.gz && \
  tar xvzf elasticsearch-versions.tar.gz && \
  rm -f elasticsearch-versions.tar.gz && \
  mv /tmp/elasticsearch-versions /elasticsearch && \
  cd /elasticsearch && \
  bin/plugin --install mobz/elasticsearch-head && \
  echo "script.disable_dynamic: false" >> config/elasticsearch.yml

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/usr/share/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
