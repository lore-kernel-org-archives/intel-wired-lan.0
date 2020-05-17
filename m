From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 17 May 2020 20:45:14 +0200
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <CA+h21hrg_CeD2-zT+7v3b3hPRFaeggmZC9NqPp+soedCYwG63A@mail.gmail.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <20200516.133739.285740119627243211.davem@davemloft.net>
 <CA+h21hoNW_++QHRob+NbWC2k7y7sFec3kotSjTL6s8eZGGT+2Q@mail.gmail.com>
 <20200516.151932.575795129235955389.davem@davemloft.net>
 <CA+h21hrg_CeD2-zT+7v3b3hPRFaeggmZC9NqPp+soedCYwG63A@mail.gmail.com>
Message-ID: <20200517184514.GD606317@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, May 17, 2020 at 01:51:19PM +0300, Vladimir Oltean wrote:
> On Sun, 17 May 2020 at 01:19, David Miller <davem@davemloft.net> wrote:
> >
> > From: Vladimir Oltean <olteanv@gmail.com>
> > Date: Sun, 17 May 2020 00:03:39 +0300
> >
> > > As to why this doesn't go to tc but to ethtool: why would it go to tc?
> >
> > Maybe you can't %100 duplicate the on-the-wire special format and
> > whatever, but the queueing behavior ABSOLUTELY you can emulate in
> > software.
> >
> > And then you have the proper hooks added for HW offload which can
> > do the on-the-wire stuff.
> >
> > That's how we do these things, not with bolted on ethtool stuff.
> 
> When talking about frame preemption in the way that it is defined in
> 802.1Qbu and 802.3br, it says or assumes nothing about queuing. It
> describes the fact that there are 2 MACs per interface, 1 MAC dealing
> with some traffic classes and the other dealing with the rest.

I did not follow the previous discussion, but i assume you talked
about modelling it in Linux as two MACs? Why was that approach not
followed?

   Andrew
