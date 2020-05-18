From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 18 May 2020 13:56:13 -0700
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <87wo59oyhr.fsf@intel.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <20200516.133739.285740119627243211.davem@davemloft.net>
 <CA+h21hoNW_++QHRob+NbWC2k7y7sFec3kotSjTL6s8eZGGT+2Q@mail.gmail.com>
 <20200516.151932.575795129235955389.davem@davemloft.net>
 <87wo59oyhr.fsf@intel.com>
Message-ID: <20200518135613.379f6a63@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 18 May 2020 12:05:04 -0700 Vinicius Costa Gomes wrote:
> David Miller <davem@davemloft.net> writes:
> > From: Vladimir Oltean <olteanv@gmail.com>
> > Date: Sun, 17 May 2020 00:03:39 +0300
> >  
> >> As to why this doesn't go to tc but to ethtool: why would it go to tc?  
> >
> > Maybe you can't %100 duplicate the on-the-wire special format and
> > whatever, but the queueing behavior ABSOLUTELY you can emulate in
> > software.  
> 
> Just saying what Vladimir said in different words: the queueing behavior
> is already implemented in software, by mqprio or taprio, for example.
> 
> That is to say, if we add frame preemption support to those qdiscs all
> they will do is pass the information to the driver, and that's it. They
> won't be able to use that information at all.
> 
> The mental model I have for this feature is that is more similar to the
> segmentation offloads, energy efficient ethernet or auto-negotiation
> than it is to a traffic shaper like CBS.

Please take a look at the example from the cover letter:

$ ethtool $ sudo ./ethtool --show-frame-preemption
enp3s0 Frame preemption settings for enp3s0:
	support: supported
	active: active
	supported queues: 0xf
	supported queues: 0xe
	minimum fragment size: 68

Reading this I have no idea what 0xe is. I have to go and query TC API
to see what priorities and queues that will be. Which IMHO is a strong
argument that this information belongs there in the first place.
