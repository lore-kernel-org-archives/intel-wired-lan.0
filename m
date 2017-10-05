From: Rodney Cummings <rodney.cummings@ni.com>
Date: Thu, 5 Oct 2017 19:17:03 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v4 3/4] net/sched:
 Introduce Credit Based Shaper (CBS) qdisc
In-Reply-To: <20171005.120508.2267452751875787466.davem@davemloft.net>
References: <CAEYbN3RjUXGMyxo0t88-ASNVEVQdfXkMzBbMtMHAhqWScOO=Cg@mail.gmail.com>
 <20171005.112909.2052593524154643514.davem@davemloft.net>
 <CY1PR0401MB1536A44D0AB459BB9618664A92700@CY1PR0401MB1536.namprd04.prod.outlook.com>
 <20171005.120508.2267452751875787466.davem@davemloft.net>
Message-ID: <CY1PR0401MB153671C2B94D23793C78B2BE92700@CY1PR0401MB1536.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

No excuse. If the software cannot meet the standard's requirements, it is non-conformant,
which means it cannot be called a standard credit-based shaper.

But... I have no objection if someone wants to try software-only. I'm just saying that it
is a waste of time for me.

> -----Original Message-----
> From: David Miller [mailto:davem at davemloft.net]
> Sent: Thursday, October 5, 2017 2:05 PM
> To: Rodney Cummings <rodney.cummings@ni.com>
> Cc: levipearson at gmail.com; jiri at resnulli.us; vinicius.gomes at intel.com;
> netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> jhs at mojatatu.com; xiyou.wangcong at gmail.com; andre.guedes at intel.com;
> ivan.briano at intel.com; jesus.sanchez-palencia at intel.com;
> boon.leong.ong at intel.com; richardcochran at gmail.com; henrik at austad.us
> Subject: Re: [next-queue PATCH v4 3/4] net/sched: Introduce Credit Based
> Shaper (CBS) qdisc
> 
> From: Rodney Cummings <rodney.cummings@ni.com>
> Date: Thu, 5 Oct 2017 18:41:48 +0000
> 
> > The IEEE Std 802.1Q specs for credit-based shaper require precise
> transmit decisions
> > within a 125 microsecond window of time.
> >
> > Even with the Preempt RT patch or similar enhancements, that isn't very
> practical
> > as software-only. I doubt that software would conform to the standard's
> > requirements.
> >
> > This is analogous to memory, or CPU.
> 
> I feel like this is looking for an excuse to not have to at least try to
> implement
> the software version of CBS.
