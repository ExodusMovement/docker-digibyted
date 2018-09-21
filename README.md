# docker-digibyted

Digibyte: [https://github.com/digibyte/digibyte](https://github.com/digibyte/digibyte)

## Usage

### Build the image

> docker build -t digibyted .

### Run example

> docker run -v /mnt/SSD-EVO/digibyte-main:/data -e "DIGIBYTED_ARGUMENTS=-datadir=/data" digibyted
