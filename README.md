
##Standing up Mobile Services With Node.js and Digital Ocean

the tagline "Digital Ocean provides blazing fast SSD cloud servers at only $5/month" does not due Cloud provider Digital Ocean justice.

In addition to the performance of the server instance ( a droplet in Digital Ocean lingo ).

Digital Ocean has become a favorite of developers for the following reasons:

- low cost performance 
- Droplets standup fast, very fast ( 59 seconds fast )
- Static external IP address for every droplet
- Droplet's disk, RAM, and IP address are all reserved while the droplet is off
- Snapshot feature allows you to save the droplet after you have destroyed the instance.  
	-- Preserving costs and making for a fast standup of your configuration for developer Sandbox  preserving costs)
	--You will be able to create a new droplet from the snapshot image anytime to bring it back online.

##Creating and Configuring your Digital Ocean Virtual Machine

Login to [Digital Ocean] (http://digitalocean.com ) and Create your droplet in less than a minute
![Image](screenshots/digitalOceanPostLogin.png?raw=true)

1. Configure your host name, Size and Region .
![Image](screenshots/digitalOceanConfigHostName.png?raw=true)
![Image](screenshots/digitalOceanConfigSize.png?raw=true)
![Image](screenshots/digitalOceanConfigRegion.png?raw=true)

2. Select your Image, in this walk through I will create it from Linux Ubuntu 12.04 x32.  However you can start from an "Application" image such as Docker or WordPress, or from one of your own "SnapShot" image ( these are great for standing up a dev stage fast).
![Image](screenshots/digitalOceanConfigImage.png?raw=true)

3. Count to 60 ... literally
![Image](screenshots/digitalOceanCreating.png?raw=true)

### Standing up your Node.js mobile services with StrongLoop

Now that your Virtual Machine droplet is up, check your email for your login, password and IP Address

![Image](screenshots/digitalOceanActive.png?raw=true)

```
Yay! Your new Droplet has been created!

You can access it using the following credentials:

IP Address: 192.111.111.111
Username: root
Password: yanzfapgryvh
```

1. From the terminal ssh to your new instance with `ssh root@192.111.111.111' and the password provided.

```
Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-24-virtual i686)

 * Documentation:  https://help.ubuntu.com/
Last login: Fri May  3 18:28:34 2013
root@MobileServices:~#
```

2. Now Lets configure the server with the StrongLoop Node distro, to make this step easier I created a small [install script](install.sh) to install dependencies get you up quickly. 

The script will update apt-get and install some of the usual suspects: python-software-properties, vim git subversion curl , memcached, build-essential, etc ( feel free to modify for your specific configurations)
s. Additionally it will download and install the latest StrongLoop Debian distro from [StrongLoop](StrongLoop.com).  Finally the script will create a /var/apps folder for you to hold your Node applications.

To run the script on your server:
  1. copy the contents of [script.sh](script.sh) to your copy buffer with CMD+Copy
  2. From the terminal you can simply 'yack yack github.com/yackyack/script.sh'
Just copy past the script to your command line with. 
  3. and then run the command with 'chmod +x script.sh; ./script.sh'

3. Stand Up your LoopBack Mobile Server with the following commands

```sh
cd /var/apps

slc lb project loopback-server
cd loopback-server
slc lb model product
slc lb model store
slc lb model customer
slc install
```

you can verify the installation by starting your server with
'slc run app.js' and open a web browser on your local machine to the servers address and the default port http://192.111.111.111:3000/explorer

Now that you have a loopback mobile server with mobile models for product, store, and customer you can use them from your mobile application development workflow.

### Integrating your Native iOS App

Now we can integrate a mobile application with our Digital Ocean SSD virtual machine and the LoopBack Node API server using the native LoopBack iOS SDK.

The best part is we don't even need to install Node or LoopBack on our local dev machine ( although this is useful if you want to run your development cycle on your local box when your disconnected from the network ).  You can download the iOS .Framework SDK directly from (http://github.com/strongloop-community)[http://github.com/strongloop-community/loopback-ios-sdk] and start with your process.

1. Clone the iOS example apps on your local machine

```sh
git clone git@github.com:strongloop-community/loopback-examples-ios.git
```

2. Open the TableView example in XCode ( you should also checkout the MapView and Remote Procedure projects as well)

You can open the XCode project with the following command on your local dev machine.

```sh
open loopback-examples-ios/ios-tableview-simple-example/tableview-example.xcodeproj
```

3. Update the endpoint URL to match you newly instantiated Digital Ocean virtual machine IP address, my modifying the AppDelegate.m file in the tableview-example group:

change :

```
+ (LBRESTAdapter *) adapter
{
    if( !_adapter)
        _adapter = [LBRESTAdapter adapterWithURL:[NSURL URLWithString:@"http://localhost:3000"]];
    return _adapter;
}
```

to

```
+ (LBRESTAdapter *) adapter
{
    if( !_adapter)
        _adapter = [LBRESTAdapter adapterWithURL:[NSURL URLWithString:@"http://192.111.111.111:3000"]];
    return _adapter;
}
```

4. Run the project in the simulator by with the Command-R hot key or press the play triangle in the top left corner of XCode.

The Examples app will leverage the "product" model that you defined when creating your LoopBack Node Server instance, so you can simply explore the code in the ViewController.m file to see how to Create, Read, Update and Delete Mobile defined models from your Objective-C iOS mobile Application.

There is no need to define a static model schema, since LoopBack will allow the Mobile Developer to define the Model attributes dynamically from the mobile Application.

Make sure and checkout the LoopBack documentation on how to leverage the built in filter functions and also to Connect your Node.js mobile objects to additional connectors or Server data stores such as MongoDB or Oracle.

### 'Snapshot' your Droplet for on demand mobile backend

Now that you have your StrongLoop Loopback server configured and your mobile application connected you can take advantage of Digital Oceans Snapshot feature.  This makes it fast and easy to spin up a mobile backend in a few seconds with zero server configuration.

### Whats Next

You can find detailed information on StrongLoop LoopBack and the native iOS SDK [StrongLoop.com](http://StrongLoop.com) and of course Digital Ocean configuration and pricing information at [Digital Ocean]( http://digitalocean.com)

If you have any questions on how JavaScript can accelerate your mobile development efforts drop us a line at [Node Republic] (http://strongloop.com/node-republic) !


