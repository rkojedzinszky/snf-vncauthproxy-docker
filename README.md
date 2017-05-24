# grnet/snf-vncauthproxy dockerized

This is an image containing grnet/snf-vncauthproxy. It needs a users file, and for ssl operation it needs
key.pem and cert.pem, which all are searched in /data in the container. So, /data should be prepared and mounted
inside.

To create the first password:

```shell
docker run --rm -it -v \
	       $(pwd)/vncapdata:/data rkojedzinszky/snf-vncauthproxy-docker \
	       sh -c 'vncauthproxy-passwd /data/users admin && chgrp vncauthproxy /data/users && chmod 640 /data/users'
```

After, start the container:

```shell
docker run -d -v $(pwd)/vncapdata:/data --name vncap --network=host rkojedzinszky/snf-vncauthproxy-docker
```

NOTE that the control port 24999 is bound on 0.0.0.0, so use firewall rules to restrict access.
