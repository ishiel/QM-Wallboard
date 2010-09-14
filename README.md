QueueMetrics has a wallboard.  Why build another?
-------------------------------------------------

Let's just say that the QueueMetrics wallboard has a face only a mother could love.

I think the QM wallboard is ugly, hard to read and it doesn't have all the useful information that your agents need.  This is my effort to make things a little better.

So this code is fantastically stable?  Right?
---------------------------------------------

Umm, well I'm using it in production and it works fine but it's currently missing a lot of much needed stuff

Missing things:

* Error handling (seriously, this isn't in here yet)
* A more efficient way of querying the QueueMetrics server
* I'm not entirely convinced that it always detects when an agent is on an outgoing call.  Sometimes QM will detect an agent is on call; other times it doesn't but they are on the Outgoing queue.  I have no idea why this is.  A fix should be do-able, I just haven't done it yet

A word of caution
-----------------

You should bear the following in mind: I'm not a professional programmer and I wrote this in a hurry.  So, you know, if this turns your phone system to custard then you're probably going to feel pretty stupid if you run this without testing it first.  Test, test and test again before you go to production.

What's it made of?
------------------

* It's written in Ruby
* It uses QM's XMLRPC API (alphabet soup!) to query realtime data.  This is done by a simple 
  class I created.  
* It uses Sinatra and HAML to present that data to a browser, and JQuery to update the data
* I've used Blueprint CSS to get a quick, sane page layout but I may drop that as it's 
  complete overkill
* It's using JQuery hosted at Google Code rather than locally.  Just laziness on my part really.
* I've ripped off the following document massively.  Well, why reinvent the wheel: 
  http://www.digitalhobbit.com/2009/11/08/building-a-twitter-filter-with-sinatra-redis-and-tweetstream/
* The colour scheme is stolen from here:
  http://colorcombos.com/color-scheme-275.html

How do I make this work?
------------------------

You will need:
* A QueueMetrics server (obviously)
* Any OS that can run Ruby (both 1.8.7 and 1.9 seem to work fine)
* The following Ruby gems: Sinatra, HAML, Configatron
* The files in this repository (again, obviously)

You need to do the following:
* Copy the files to a folder (maintaining the folder structure)
* Edit config.yml so that it has the following info: server and port are the ip address and 
  port of your server, which should be clearly visible in the QM URL.  The path probably 
  doesn't need to change.  Queue is the queue you want to manage, as seen in the QM 
  application.  User and password is the credentials you use to login to QM (you should 
  probably create an account specially for your wallboard).
* To run the app just do the following:
        ruby qm_web.rb

Some things you might want to change:
* The wallboard updates every ten seconds.  If you edit ./views/index.haml you can change the 
  values in the javascript block from 10000 to anything you wish.  I wouldn't recommend 
  setting it lower than that.
* You can change the default font size.  If you edit ./public/css/style.css you can change 
  the font-size in the body block and this will change everything else proportionally.

