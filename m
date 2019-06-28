From: David Miller <davem@davemloft.net>
Date: Fri, 28 Jun 2019 14:46:47 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next v6 0/8] net/sched: Add
 txtime-assist support for taprio.
In-Reply-To: <1561500439-30276-1-git-send-email-vedang.patel@intel.com>
References: <1561500439-30276-1-git-send-email-vedang.patel@intel.com>
Message-ID: <20190628.144647.570493656550419800.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vedang Patel <vedang.patel@intel.com>
Date: Tue, 25 Jun 2019 15:07:11 -0700

> Currently, we are seeing packets being transmitted outside their
> timeslices. We can confirm that the packets are being dequeued at the right
> time. So, the delay is induced after the packet is dequeued, because
> taprio, without any offloading, has no control of when a packet is actually
> transmitted.
> 
> In order to solve this, we are making use of the txtime feature provided by
> ETF qdisc. Hardware offloading needs to be supported by the ETF qdisc in
> order to take advantage of this feature. The taprio qdisc will assign
> txtime (in skb->tstamp) for all the packets which do not have the txtime
> allocated via the SO_TXTIME socket option. For the packets which already
> have SO_TXTIME set, taprio will validate whether the packet will be
> transmitted in the correct interval.
> 
> In order to support this, the following parameters have been added:
> - flags (taprio): This is added in order to support different offloading
>   modes which will be added in the future.
> - txtime-delay (taprio): This indicates the minimum time it will take for
>   the packet to hit the wire after it reaches taprio_enqueue(). This is
>   useful in determining whether we can transmit the packet in the remaining
>   time if the gate corresponding to the packet is currently open.
> - skip_skb_check (ETF): ETF currently drops any packet which does not have
>   the SO_TXTIME socket option set. This check can be skipped by specifying
>   this option.
 ...

Series applied, thanks.
