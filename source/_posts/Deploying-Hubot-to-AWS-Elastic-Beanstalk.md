title: Deploying Hubot to AWS Elastic Beanstalk
date: 2015-10-13 21:29
tags:
categories: [Tips & Tuts]
---

If you haven't already embraced the ChatOps methodology it's time to seriously consider it. Coining the term, the folks over at Github describe it as "putting tools in the middle of the conversation". Their widely adopted implementation of this is through Hubot. Hubot runs on Node.js offering a light-weight backend but also the extensibility that Node.js offers.

To gain the ChatOps benefits from Hubot you'll want to run it somewhere that allows it access to internal resources. Ths way you can interact with your proprietary systems without exposing them to the internet. Should you find yourself in a place where you're either comfortable connecting your VPC to your local network or simply don't care about interacting with local resources this article is for you. Deploying Hubot to AWS Beanstalk is great because it has the scaling availability that Beanstalk offers coupled with the cheap pricing of EC2. Most hubot instances will easily fall within EC2's free tier.

## Create a Hubot
Before we discuss deploying Hubot, let's make sure you have an instance of Hubot ready to deploy. When you can run it locally and it successfully connects to the adapter of your choice, we'll move on. Check out [Getting Started With Hubot](https://hubot.github.com/docs/#getting-started-with-hubot) and build your Hubot instance. Don't worry, we'll wait for you.


## Setup AWS
We'll be using the Elastic Beanstalk CLI to deploy. You can find the docs [here](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html). Here's the gist

1. Ensure you have `pip` installed
  ```bash
  sudo apt-get install python-pip
  ```
2. Install the AWS EB CLI
  ```bash
  sudo pip install awsebcli
  ```

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

## Create the EB Application
Configure EB. If you have a VPC, select the region where it exists. Otherwise the default is sufficient.

```bash
eb init

# Select a default region
# 1) us-east-1 : US East (N. Virginia)
# 2) us-west-1 : US West (N. California)
# 3) us-west-2 : US West (Oregon)
# 4) eu-west-1 : EU (Ireland)
# 5) eu-central-1 : EU (Frankfurt)
# 6) ap-southeast-1 : Asia Pacific (Singapore)
# 7) ap-southeast-2 : Asia Pacific (Sydney)
# 8) ap-northeast-1 : Asia Pacific (Tokyo)
# 9) sa-east-1 : South America (Sao Paulo)
# 10) cn-north-1 : China (Beijing)
# (default is 3): 
3
```

If this is your first time using EB you'll be prompted to enter your AWS credentials.. If you don't have these you can generate them [here](https://console.aws.amazon.com/iam/home#users). Ensure that the user you use has access to provision EC2 instances
```bash
# You have not yet set up your credentials or your credentials are incorrect 
# You must provide your credentials.
# (aws-access-id): 
<your aws-access-id>
# (aws-secret-key): 
<your aws-secret-key>
```

Now we'll create the app.
```bash
# Enter Application Name
# (default is "Desktop"): 
hubot
# Application hubot has been created.
```
Be sure to select the Node.js platform
```bash
# Select a platform.
# 1) Node.js
# 2) PHP
# 3) Python
# 4) Ruby
# 5) Tomcat
# 6) IIS
# 7) Docker
# 8) Multi-container Docker
# 9) GlassFish
# 10) Go
# 11) Java
# (default is 1):
1
```
For hubot, we don't need to setup SSH
```bash
# Do you want to set up SSH for your instances?
# (y/n): 
n
```
At this point you should be able to see the empty application provisioned on the [Beanstalk Console](https://console.aws.amazon.com/elasticbeanstalk/home). Protip: make sure you're viewing the region you previously chose. You can witch regions at the top right.

# Create an EB Environment
Before we can deploy, we need to setup an environment to deploy to. We can create one with `eb create` or select an already existing environment with `eb use my-env-name`
```bash
eb create
# Enter Environment Name
# (default is hubot-dev): 
production
# Enter DNS CNAME prefix
# (default is hubot-dev)
# Creating application version archive "app".
# Uploading hubot/app.zip to S3. This may take a while.
# Upload Complete.
```
Hubot configuration is pulled from environment variables. To set environment variables for your EB Environment we'll use `eb setenv`
```bash
eb setenv HUBOT_SLACK_TOKEN=xxxxx
# INFO: Environment update is starting.                               
# INFO: Updating environment demo-production's configuration settings.
```

# Deploy
Finally, we can deploy this beast.
```bash
eb deploy
```

Be sure to check out the status of your instance in the [Beanstalk Console](https://console.aws.amazon.com/elasticbeanstalk/home). Once the application is fully deployed you can view its status and logs from the console or using the EB CLI.
