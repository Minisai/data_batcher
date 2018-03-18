# README

## Start everything

```
docker-compose up --build --scale app=5
```

## Reset the database

```
docker-compose exec --user "$(id -u):$(id -g)" app rails db:reset
```

## Migrate the database

```
docker-compose exec --user "$(id -u):$(id -g)" app rails db:migrate
```

## Configuration

.env file contains the default values. Feel free to configure them:

```
EVENTS_BATCH_LIMIT=10 # length of events batch
BACKOFF_DURATION=60   # backoff duration in seconds, time the system waits before forced events sending
CONSUMER_URL=mirror   # external service url. Using mirror-http server for default
```


## How to test

* Use curl command for testing:

```
curl -X POST http://127.0.0.1:300[0-4]/events\?event\=evt1
```

* Wait for 60 seconds or send 9 more events

* See the mirror service output in the console:

```
mirror_1    | [2018-03-18T21:52:04.924Z]  INFO: mirror-http-server/16 on 1c71fa80f272: 
mirror_1    |     request: {
mirror_1    |       "ip": "172.18.0.6",
mirror_1    |       "ips": [],
mirror_1    |       "method": "POST",
mirror_1    |       "url": "/",
mirror_1    |       "headers": {
mirror_1    |         "accept": "*/*",
mirror_1    |         "accept-encoding": "gzip, deflate",
mirror_1    |         "user-agent": "rest-client/2.0.2 (linux-musl x86_64) ruby/2.5.0p0",
mirror_1    |         "content-length": "12",
mirror_1    |         "content-type": "application/x-www-form-urlencoded",
mirror_1    |         "host": "mirror"
mirror_1    |       },
mirror_1    |       "body": {
mirror_1    |         "events": [
mirror_1    |           "evt1"
mirror_1    |         ]
mirror_1    |       }
mirror_1    |     }
```
