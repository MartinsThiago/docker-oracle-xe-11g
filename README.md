oraclexe-11g-fig
============================

Oracle Express Edition 11g Release 2 on Ubuntu 14.04.1 LTS

This is a fork from wnameless/docker-oracle-xe-11g to provide simple usage with fig and provisioning capabilities.

### Installation
```
docker pull martinsthiago/oraclexe-11g-fig
```

### Provisioning
Place your scripts into the container in `/provision`, here is a simple provision script

```
echo "CREATE TABLE TODO(
    TITLE VARCHAR(),
    SUBTITLE VARCHAR(),
    CREATED_ON VARCHAR()
);" | sqlplus system/oracle
```

### Running With Docker
Run with port 1521 opened, optionally expose port 8080 for apex:
```
docker run -dt -p 8080:8080 -p 1521:1521 martinsthiago/oraclexe-11g-fig
```

### Running With Fig
In case you use fig, create a `fig.yml` like the one bellow

```
db:
  from: martinsthiago/oraclexe-11g-fig
  volumes:
  - ./provision:/provision
  ports:
  - "1521:1521"
  - "8080:8080"
```

Then run `fig up db` then `fig start db` 

### Database Connection
Connect database with following setting:
```
hostname: localhost
port: 1521
sid: xe
username: system
password: oracle
```

Password for SYS & SYSTEM
```
oracle
```
