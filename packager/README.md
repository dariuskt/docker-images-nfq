## Packager toolbox

### Info
This image is used to help build deb packages for projects. Also to test it against Debian lintian

### Usage
package-deb input out-path

### Input structure
```
input_dir
├── changelog  				[debian package changelog, required]
├── changelog-upstream		[upstream changelog, optional]
├── copyright				[copyright information, required]
├── DEBIAN					[deb package control section]
    └── control
```

### Configuration
Available binary paths for export:

- /usr/local/bin/package-deb

### Sample configuration
```
version: '2.4'
services:
  packager:
    image: nfqlt/packager
    volumes:
      - /tmp
      - ./src:/home/project/src


  dev:
    image: nfqlt/php73-dev
    volumes_from:
      - service:packager:rw
    volumes:
      - ./src:/home/project/src
      - /home/project/.ssh:/home/project/.ssh
      - /etc/ssh:/etc/ssh
      - /etc/gitconfig:/etc/gitconfig
      - /etc/environment:/etc/environment-vm:ro
    environment:
      NFQ_REMOTE_TOOL_PACKAGER: >
        /usr/local/bin/package-deb


  linker:
    image: nfqlt/linker18ce
    volumes:
      - /run/docker.sock:/run/docker.sock
```

