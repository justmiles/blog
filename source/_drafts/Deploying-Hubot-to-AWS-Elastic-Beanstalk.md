title: Deploying Hubot to AWS Elastic Beanstalk
tags:
---

If you haven't already embraced the ChatOps methodology it's time to seriously consider it. Coining the term, the folks over at Github describe it as "putting tools in the middle of the conversation". Their widely adopted implementation of this is through Hubot. Hubot runs on Node.js offering a light-weight backend but also the extensibility that Node.js offers.

## Enough about Hobot - how do we run it?
To gain the ChatOps benefits from Hubot you'll want to run it somewhere that allows it access to internal resources. That way you can interact with your proprietary systems without exposing yourself to the interwebs. Should you find yourself in a place where you're either comfortable connecting your VPC to your local network or simply don't care about interacting with local resources you might find that deploying Hubot to AWS Beanstalk is a good choice. With low amounts of resources required for Hubot it easily falls into AWS' free tier.

## Create a Hubot
Before we discuss deploying Hubot, let's make sure you have an instance of Hubot ready to deploy. When you can run it locally and it successfully connects to the adapter of your choice, we'll move on. Check out [Getting Started With Hubot](https://hubot.github.com/docs/#getting-started-with-hubot) and build your Hubot instance. Don't worry, we'll wait for you.


## Setup AWS
We'll be using the Elastic Beanstalk CLI to deploy. You can find the docs [here](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html). 

## Configure Hubot for EB
EB by default will run `npm start` to kick off your node app. This makes it easy for us to pragmatically define our startup options. We can configure npm's `start` script in the `package.json` file. Note that coffee-script isn't in EB's PATH by default, so we'll call it directly before calling Hubot with its various options.
```json
{
  "name": "hubot",
  "version": "1.0.0",
  "scripts": {
    "start": "node node_modules/coffee-script/bin/coffee node_modules/hubot/bin/hubot --name hubot --adapter slack"
  },
  "dependencies": {
    "coffee-script": "1.9.0"
  }
}
```

You can test this by running `npm start`. Be sure to set any environment variables