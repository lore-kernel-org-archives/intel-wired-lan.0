From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 7 Sep 2017 14:40:18 +0200
Subject: [Intel-wired-lan] [RFC net-next 0/5] TSN: Add qdisc-based
 config interfaces for traffic shapers
In-Reply-To: <20170907053411.GA6580@sisyphus.home.austad.us>
References: <20170901012625.14838-1-vinicius.gomes@intel.com>
 <20170907053411.GA6580@sisyphus.home.austad.us>
Message-ID: <20170907124018.deinzo3c4ice3q7n@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 07, 2017 at 07:34:11AM +0200, Henrik Austad wrote:
> Also, does this mean that when you create the qdisc, you have locked the 
> bandwidth for the scheduler? Meaning, if I later want to add another 
> stream that requires more bandwidth, I have to close all active streams, 
> reconfigure the qdisc and then restart?

No, just allocate enough bandwidth to accomodate all of the expected
streams.  The streams can start and stop at will.

> So my understanding of all of this is that you configure the *total* 
> bandwith for each class when you load the qdisc and then let userspace 
> handle the rest. Is this correct?

Nothing wrong with that.
 
> In my view, it would be nice if the qdisc had some notion about streams so 
> that you could create a stream, feed frames to it and let the driver pace 
> them out. (The fewer you queue, the shorter the delay). This will also 
> allow you to enforce per-stream bandwidth restrictions. I don't see how you 
> can do this here unless you want to do this in userspace.
> 
> Do you have any plans for adding support for multiplexing streams? If you 
> have multiple streams, how do you enforce that one stream does not eat into 
> the bandwidth of another stream? AFAIK, this is something the network must 
> enforce, but I see no option of doing som here.

Please, lets keep this simple.  Today we have exactly zero user space
applications using this kind of bandwidth reservation.  The case of
wanting the kernel to police individual stream usage does not exist,
and probably never will.

For serious TSN use cases, the bandwidth needed by each system and
indeed the entire network will be engineered, and we can reasonably
expect applications to cooperate in this regard.

Thanks,
Richard
