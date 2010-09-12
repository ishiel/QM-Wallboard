QueueMetrics has a wallboard.  Why build another?
=================================================

Are you kidding?  Have you seen that monstrosity?

I think the QM wallboard is ugly, illegible and it doesn't have all the useful information that your agents need.  This is my effort to make things a little better.

So this code is fantastically stable?  Right?
=============================================

Umm, well I'm using it in production and it works fine but it's currently missing a lot of much needed stuff

Missing things:
* Error handling (seriously, this isn't in here yet)
* A more efficient way of querying the server

You should bear the following in mind: I'm not a professional programmer and I wrote this in a hurry.  So, you know, if this turns your phone system to custard then you're probably going to feel pretty stupid for having listened to me.  Test, test and test again before you go to production.

What's it made of?
==================

* It's written in Ruby
* It uses QM's XMLRPC API (alphabet soup!) to query realtime data.  This is done by a simple class I created.  
* It uses Sinatra and HAML to present that data to a browser, and JQuery to update the data
* I've used Blueprint CSS to get a quick, sane page layout but I may drop that as it's complete overkill
* I've ripped off the following document massively.  Well, why reinvent the wheel: http://www.digitalhobbit.com/2009/11/08/building-a-twitter-filter-with-sinatra-redis-and-tweetstream/