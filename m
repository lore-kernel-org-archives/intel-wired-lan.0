From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 07 Dec 2020 14:49:35 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 0/9] ethtool: Add support
 for frame preemption
In-Reply-To: <20201205095021.36e1a24d@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <20201202045325.3254757-1-vinicius.gomes@intel.com>
 <20201205095021.36e1a24d@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Message-ID: <87o8j5z0xs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue,  1 Dec 2020 20:53:16 -0800 Vinicius Costa Gomes wrote:
>> $ tc qdisc replace dev $IFACE parent root handle 100 taprio \
>>       num_tc 3 \
>>       map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
>>       queues 1 at 0 1 at 1 2 at 2 \
>>       base-time $BASE_TIME \
>>       sched-entry S 0f 10000000 \
>>       preempt 1110 \
>>       flags 0x2 
>> 
>> The "preempt" parameter is the only difference, it configures which
>> queues are marked as preemptible, in this example, queue 0 is marked
>> as "not preemptible", so it is express, the rest of the four queues
>> are preemptible.
>
> Does it make more sense for the individual queues to be preemptible 
> or not, or is it better controlled at traffic class level?
> I was looking at patch 2, and 32 queues isn't that many these days..
> We either need a larger type there or configure this based on classes.

I can set more future proof sizes for expressing the queues, sure, but
the issue, I think, is that frame preemption has dimishing returns with
link speed: at 2.5G the latency improvements are on the order of single
digit microseconds. At greater speeds the improvements are even less
noticeable.

The only adapters that I see that support frame preemtion have 8 queues
or less. 

The idea of configuring frame preemption based on classes is
interesting. I will play with it, and see how it looks.


Cheers,
-- 
Vinicius
