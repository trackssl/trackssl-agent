# trackssl-agent

## Docker

### Building

```
docker build --tag trackssl-agent .
```

### Executing

```
docker run --rm -i -t --env-file .env trackssl-agent
```

### Publishing releases manually

```
echo $CR_PAT | docker login ghcr.io --username USERNAME --password-stdi
```

```
docker tag trackssl-agent:latest ghcr.io/trackssl/trackssl-agent:latest
```

```
docker push ghcr.io/trackssl/trackssl-agent:latest
```


## Environment Variables

* TRACKSSL_AUTH_TOKEN - Trackssl API token.
* TRACKSSL_AGENT_TOKEN - Identifies a particular agent.
* TRACKSSL_URL - optional URL to trackssl.  Defaults to https://app.trackss.com.

