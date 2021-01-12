FROM node:alpine

RUN npm install -g tiddlywiki

WORKDIR /opt/wiki/

# CMD tiddlywiki main --listen "readers=(anon)" writers=user credentials=/opt/wiki/creds.csv host=0.0.0.0 port=5000 root-tiddler=$:/core/save/all root-render-type=text/plain root-serve-type=text/html
# CMD tiddlywiki $WIKINAME --listen "readers=user" writers=user credentials=/opt/wiki/creds.csv host=0.0.0.0 port=5000 root-tiddler=$:/core/save/all root-render-type=text/plain root-serve-type=text/html
CMD tiddlywiki $WIKINAME --listen "readers=ram" writers=ram credentials=/opt/wiki/creds.csv host=0.0.0.0 port=5000 root-tiddler=$:/core/save/lazy-all root-render-type=text/plain root-serve-type=text/html
