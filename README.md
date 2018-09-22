# docker-digibyted

Digibyte: [https://github.com/digibyte/digibyte](https://github.com/digibyte/digibyte)

Image location: [https://quay.io/repository/exodusmovement/digibyted](https://quay.io/repository/exodusmovement/digibyted)

Every new digibyted release have own branch where branch name is digibyted version. For each docker image release we create tag `BRANCH_NAME-xxx`, where `xxx` is release version for *current* branch. Docker image with latest tag is used only for development and contain last build (please do not use it for production!).

Branches and releases:

 - [6.16.5.1](https://github.com/ExodusMovement/docker-digibyted/tree/6.16.5.1)
   - [6.16.5.1-001](https://github.com/ExodusMovement/docker-digibyted/tree/6.16.5.1-001)
 - [6.16.3](https://github.com/ExodusMovement/docker-digibyted/tree/6.16.3)
   - [6.16.3-001](https://github.com/ExodusMovement/docker-digibyted/tree/6.16.3-001)

## Usage

### Build the image

> docker build -t digibyted .

### Run example

> docker run -v /mnt/SSD-EVO/digibyte-main:/data -e "DIGIBYTED_ARGUMENTS=-datadir=/data" digibyted
