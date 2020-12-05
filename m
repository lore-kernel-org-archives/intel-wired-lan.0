From: Jakub Kicinski <kuba@kernel.org>
Date: Sat, 5 Dec 2020 09:50:21 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 0/9] ethtool: Add support
 for frame preemption
In-Reply-To: <20201202045325.3254757-1-vinicius.gomes@intel.com>
References: <20201202045325.3254757-1-vinicius.gomes@intel.com>
Message-ID: <20201205095021.36e1a24d@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue,  1 Dec 2020 20:53:16 -0800 Vinicius Costa Gomes wrote:
> $ tc qdisc replace dev $IFACE parent root handle 100 taprio \
>       num_tc 3 \
>       map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
>       queues 1 at 0 1 at 1 2 at 2 \
>       base-time $BASE_TIME \
>       sched-entry S 0f 10000000 \
>       preempt 1110 \
>       flags 0x2 
> 
> The "preempt" parameter is the only difference, it configures which
> queues are marked as preemptible, in this example, queue 0 is marked
> as "not preemptible", so it is express, the rest of the four queues
> are preemptible.

Does it make more sense for the individual queues to be preemptible 
or not, or is it better controlled at traffic class level?
I was looking at patch 2, and 32 queues isn't that many these days..
We either need a larger type there or configure this based on classes.
