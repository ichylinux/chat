## Chat application sample run at magellan

### Usage

1. **Build your own docker image**
<pre>
  $ git clone https://github.com/ichylinux/chat.git
  $ cd chat
  $ bundle install
  $ rake db:create
  $ rake db:reset
  $ rake test
  $ docker build -t yourname/chat:1.0.0 .
  $ docker push yourname/chat:1.0.0
</pre>

1. **Configure on magellan**

  Follow instruction at http://devcenter.magellanic-clouds.com/getting-started/tutorial/worker/rails/deployment.html
