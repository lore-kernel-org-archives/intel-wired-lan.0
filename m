From: David Miller <davem@davemloft.net>
Date: Thu, 05 Oct 2017 12:05:08 -0700 (PDT)
Subject: [Intel-wired-lan] [next-queue PATCH v4 3/4] net/sched:
 Introduce Credit Based Shaper (CBS) qdisc
In-Reply-To: <CY1PR0401MB1536A44D0AB459BB9618664A92700@CY1PR0401MB1536.namprd04.prod.outlook.com>
References: <CAEYbN3RjUXGMyxo0t88-ASNVEVQdfXkMzBbMtMHAhqWScOO=Cg@mail.gmail.com>
 <20171005.112909.2052593524154643514.davem@davemloft.net>
 <CY1PR0401MB1536A44D0AB459BB9618664A92700@CY1PR0401MB1536.namprd04.prod.outlook.com>
Message-ID: <20171005.120508.2267452751875787466.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Rodney Cummings <rodney.cummings@ni.com>
Date: Thu, 5 Oct 2017 18:41:48 +0000

> The IEEE Std 802.1Q specs for credit-based shaper require precise transmit decisions
> within a 125 microsecond window of time.
> 
> Even with the Preempt RT patch or similar enhancements, that isn't very practical
> as software-only. I doubt that software would conform to the standard's
> requirements.
> 
> This is analogous to memory, or CPU.

I feel like this is looking for an excuse to not have to at least try to implement
the software version of CBS.
