# Before start

```ca.crt``` must be installed in
- ```config/nebula/common```

```ca.key``` must be installed in
- ```config/nebula/guacd```

Each folder in ```config/nebula``` must have ```.crt``` and ```.key``` files with same name of the directory.

# Build
```docker build -t lziosi/guacd-nebulardp:0.0.3 -f- . < Dockerfile-guacd```<br>
```docker build -t lziosi/rdphost-nebulardp:0.0.3 -f- . < Dockerfile-rdphost```

# Start
```docker-compose up```