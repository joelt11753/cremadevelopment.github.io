---
layout: post
title: In Need Content!
tags:
- elasticsearch
- elastic
- search
- docker
---

The other day I was at a workshop pre-event for [.Net Fringe](http://dotnetfringe.org). The workshop was working with [elasticsearch](https://www.elastic.co). As the workshop got underway there was a bunch of usb sticks that the presenters had preloaded with the things needed for the workshop. As I obtained one of these and pulled it to my machine I dug through the files. We were instructed to unzip a folder and run a .bat file to get elastic search up and running. Easy enough, right. I cracked the zip and did as instructed and there was an error. The instructor told me that they had never seen that error before, and directed me to an msi. So I thought about it for a moment, and was hesitant as I keep a relatively clean machine. 

From there I jumped out to hub.docker.com and found the elasticsearch image **but don't use that one**... The first word in the description, if you read it, is *Deprecated*. In the first part of it you will also find a link to the [elastic.co docker repository](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html) where you can get the url to pull the new official elasticsearch docker image.

```docker pull docker.elastic.co/elasticsearch/elasticsearch:5.4.1```

This was great I was going to get elasticsearch up and running without actually installing anything on my machine. Literaly I downloaded a container with elasticsearch in it and configured by people that know it better than I do, and I turned it on...

```docker run -p 9200:9200 -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" docker.elastic.co/elasticsearch/elasticsearch:5.4.1```

However reading a bit more I found that X-Pack security was installed in the image. This was going to take more configuration to change passwords or turn off the security portion. Since I was just looking to participate in the workshop I asked one of the presenters and he mentioned that X-Pack can be removed relatively easily, so looking into it a bit on the [elasticsearch/plugins](https://www.elastic.co/guide/en/elasticsearch/plugins/2.2/listing-removing.html) I found that in the plugin directory if you run `remove x-pack` it should be removed.

```RUN /usr/share/elasticsearch/bin/elasticsearch-plugin remove x-pack```

From this a dockerfile was created.

```
FROM docker.elastic.co/elasticsearch/elasticsearch:5.4.1

USER root

#Remove X-Pack
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin remove x-pack

USER elasticsearch
```

That being said if you build that with

```docker build -t carbar/elasticsearch:1.0.0 .```

Then run it with

```docker run -p 9200:9200 -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" carbar/elasticsearch```

And *badaboom* you now have a localhost:9200 url that will 