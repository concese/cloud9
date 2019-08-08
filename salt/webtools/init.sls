/mnt/docker:
  file.directory:
    - user:  ec2-user
    - group: ec2-user
    - name:  /mnt/docker
/mnt/docker/datas/elasticsearch:
  file.directory:
    - user:  1000
    - name:  /mnt/docker/datas/elasticsearch
/mnt/docker/webtools-docker-compose.yml:
  file.managed:
    - template: jinja
    - source: salt://webtools/files/docker-compose.yml
    - user:  ec2-user
    - group: ec2-user
    - require: 
      - file: /mnt/docker
start-containers:
  cmd.run:
    - name: |
        /usr/local/bin/docker-compose -f /mnt/docker/webtools-docker-compose.yml up -d --force-recreate
    - require:
      - file: /mnt/docker/webtools-docker-compose.yml
