# TiddlyWiki

* https://tiddlywiki.com/
* Server Source https://tiddlywiki.com/static/ServerCommand.html
* https://github.com/djmaze/tiddlywiki-docker


```
sudo docker run -d -p 8080:8080 -v $(pwd)/.tiddlywiki:/var/lib/tiddlywiki mazzolino/tiddlywiki
sudo docker run -d -p 8080:8080 -v $($HOME)/.tiddlywiki:/var/lib/tiddlywiki mazzolino/tiddlywiki
```

Sign in with is `user` / `wiki`


