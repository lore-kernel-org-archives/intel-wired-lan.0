From: Rodney Cummings <rodney.cummings@ni.com>
Date: Thu, 5 Oct 2017 18:41:48 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v4 3/4] net/sched:
 Introduce Credit Based Shaper (CBS) qdisc
In-Reply-To: <20171005.112909.2052593524154643514.davem@davemloft.net>
References: <20171004002831.18371-4-vinicius.gomes@intel.com>
 <20171004063650.GA1895@nanopsycho>
 <CAEYbN3RjUXGMyxo0t88-ASNVEVQdfXkMzBbMtMHAhqWScOO=Cg@mail.gmail.com>
 <20171005.112909.2052593524154643514.davem@davemloft.net>
Message-ID: <CY1PR0401MB1536A44D0AB459BB9618664A92700@CY1PR0401MB1536.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The IEEE Std 802.1Q specs for credit-based shaper require precise transmit decisions
within a 125 microsecond window of time.

Even with the Preempt RT patch or similar enhancements, that isn't very practical
as software-only. I doubt that software would conform to the standard's
requirements.

This is analogous to memory, or CPU.
.

> -----Original Message-----
> From: David Miller [mailto:davem at davemloft.net]
> Sent: Thursday, October 5, 2017 1:29 PM
> To: levipearson at gmail.com
> Cc: jiri at resnulli.us; vinicius.gomes at intel.com; netdev at vger.kernel.org;
> intel-wired-lan at lists.osuosl.org; jhs at mojatatu.com;
> xiyou.wangcong at gmail.com; andre.guedes at intel.com; ivan.briano at intel.com;
> jesus.sanchez-palencia at intel.com; boon.leong.ong at intel.com;
> richardcochran at gmail.com; henrik at austad.us; Rodney Cummings
> <rodney.cummings@ni.com>
> Subject: Re: [next-queue PATCH v4 3/4] net/sched: Introduce Credit Based
> Shaper (CBS) qdisc
> 
> From: Levi Pearson <levipearson@gmail.com>
> Date: Thu, 5 Oct 2017 12:09:32 -0600
> 
> > It would be a shame if this were blocked due to a missing software
> > implementation.
> 
> Quite the contrary, I think a software implementation is a minimum
> requirement for inclusion of this feature.
> 
> Without a software implementation, there is no clear definition of
> what is supposed to happen, and no clear way for people to test those
> expectations unless they have the specific hardware.
> 
> I completely agree with Jiri.  Hardware offload first is _not_ how
> we do things in the Linux networking.
