#!/bin/bash
set -e

# setup environment
DIR="./db"
H2_VERSION="2.4.240"
H2_JAR="h2-${H2_VERSION}.jar"
H2_DOWNLOAD="https://repo1.maven.org/maven2/com/h2database/h2/${H2_VERSION}/${H2_JAR}"
H2_FILE="${DIR}/${H2_JAR}"

if ! [ -d "${DIR}" ]; then
  mkdir -p "${DIR}"
fi

# installation of h2 if missing
if [ ! -f "${H2_FILE}" ]; then
  echo "H2 database not found. Installing..."
  wget -q -O "${H2_FILE}" "${H2_DOWNLOAD}"
  echo "H2 database installed."
fi

# Start the H2 database server
cd db
java -cp ${H2_JAR} org.h2.tools.Server -tcpPort 9092 -webPort 19999 -baseDir . -ifNotExists


