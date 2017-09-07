From: Henrik Austad <henrik@austad.us>
Date: Thu, 7 Sep 2017 18:18:38 +0200
Subject: [Intel-wired-lan] [RFC net-next 0/5] TSN: Add qdisc-based
 config interfaces for traffic shapers
In-Reply-To: <20170907155315.5gqy5e4susl25wa2@localhost>
References: <20170901012625.14838-1-vinicius.gomes@intel.com>
 <20170907053411.GA6580@sisyphus.home.austad.us>
 <20170907124018.deinzo3c4ice3q7n@localhost>
 <20170907152751.GA9064@sisyphus.home.austad.us>
 <20170907155315.5gqy5e4susl25wa2@localhost>
Message-ID: <20170907161838.GB9064@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 07, 2017 at 05:53:15PM +0200, Richard Cochran wrote:
> On Thu, Sep 07, 2017 at 05:27:51PM +0200, Henrik Austad wrote:
> > On Thu, Sep 07, 2017 at 02:40:18PM +0200, Richard Cochran wrote:
> > And if you want to this driver to act as a bridge, how do you accomodate 
> > change in network requirements? (i.e. how does this work with switchdev?)
> 
> To my understanding, this Qdisc idea provides QoS for the host's
> transmitted traffic, and nothing more.

Ok, then we're on the same page.

> > - Or am I overthinking this?
> 
> Being able to configure the external ports of a switchdev is probably
> a nice feature, but that is another story.  (But maybe I misunderstood
> the authors' intent!)

ok, chalk that one up for later perhaps

> > If you have more than 1 application in userspace that wants to send data 
> > using this scheduler, how do you ensure fair transmission of frames? (both 
> > how much bandwidth they use,
> 
> There are many ways to handle this, and we shouldn't put any of that
> policy into the kernel.  For example, there might be a monolithic
> application with configurable threads, or an allocation server that
> grants bandwidth to applications via IPC, or a multiplexing stream
> server like jack, pulse, etc, and so on...

true

> > but also ordering of frames from each application)
> 
> Not sure what you mean by this.

Fair enough, I'm not that good at making myself clear :)

Let's see if I can make a better attempt:

If you have 2 separate applications that have their own streams going to 
different endpoints - but both are in the same class, then they will 
share the qdisc bandwidth.

So application 
- A sends frame A1, A2, A3, .. An
- B sends B1, B2, .. Bn

What I was trying to describe was: if application A send 2 frames, and B 
sends 2 frames at the same time, then you would hope that the order would 
be A1, B1, A2, B2, and not A1, A2, B1, B2.

None of this would be a problem if you expect a *single* user, like the 
allocation server you described above. Again, I think this is just me 
overthinking the problem right now :)

> > Do you expect all of this to be handled in userspace?
> 
> Yes, I do.

ok, fair enough

Thanks for answering my questions!

-- 
Henrik Austad
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170907/9b81992f/attachment.asc>
