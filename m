From: Henrik Austad <henrik@austad.us>
Date: Thu, 7 Sep 2017 17:27:51 +0200
Subject: [Intel-wired-lan] [RFC net-next 0/5] TSN: Add qdisc-based
 config interfaces for traffic shapers
In-Reply-To: <20170907124018.deinzo3c4ice3q7n@localhost>
References: <20170901012625.14838-1-vinicius.gomes@intel.com>
 <20170907053411.GA6580@sisyphus.home.austad.us>
 <20170907124018.deinzo3c4ice3q7n@localhost>
Message-ID: <20170907152751.GA9064@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 07, 2017 at 02:40:18PM +0200, Richard Cochran wrote:
> On Thu, Sep 07, 2017 at 07:34:11AM +0200, Henrik Austad wrote:
> > Also, does this mean that when you create the qdisc, you have locked the 
> > bandwidth for the scheduler? Meaning, if I later want to add another 
> > stream that requires more bandwidth, I have to close all active streams, 
> > reconfigure the qdisc and then restart?
> 
> No, just allocate enough bandwidth to accomodate all of the expected
> streams.  The streams can start and stop at will.

Sure, that'll work.

And if you want to this driver to act as a bridge, how do you accomodate 
change in network requirements? (i.e. how does this work with switchdev?)
- Or am I overthinking this?

> > So my understanding of all of this is that you configure the *total* 
> > bandwith for each class when you load the qdisc and then let userspace 
> > handle the rest. Is this correct?
> 
> Nothing wrong with that.

Didn't mean to say it was wrong, just making sure I've understood the 
concept.

> > In my view, it would be nice if the qdisc had some notion about streams so 
> > that you could create a stream, feed frames to it and let the driver pace 
> > them out. (The fewer you queue, the shorter the delay). This will also 
> > allow you to enforce per-stream bandwidth restrictions. I don't see how you 
> > can do this here unless you want to do this in userspace.
> > 
> > Do you have any plans for adding support for multiplexing streams? If you 
> > have multiple streams, how do you enforce that one stream does not eat into 
> > the bandwidth of another stream? AFAIK, this is something the network must 
> > enforce, but I see no option of doing som here.
> 
> Please, lets keep this simple. 

Simple is always good

> Today we have exactly zero user space
> applications using this kind of bandwidth reservation.  The case of
> wanting the kernel to police individual stream usage does not exist,
> and probably never will.

That we have *zero* userspace applications today is probably related to the 
fact that we have exacatly *zero* drivers in the kernel that talks TSN :)

To rephrase a bit, what I'm worried about:

If you have more than 1 application in userspace that wants to send data 
using this scheduler, how do you ensure fair transmission of frames? (both 
how much bandwidth they use, but also ordering of frames from each 
application) Do you expect all of this to be handled in userspace?

> For serious TSN use cases, the bandwidth needed by each system and
> indeed the entire network will be engineered, and we can reasonably
> expect applications to cooperate in this regard.

yes.. that'll happen ;)

> Thanks,
> Richard

Don't get me wrong, I think it is great that others are working on this!
I'm just trying to fully understand the thought that have gone into this 
and how it is inteded to be used.

I'll get busy testing the code and wrapping my head around the different 
parameters.

-- 
Henrik Austad
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170907/960e74a4/attachment.asc>
