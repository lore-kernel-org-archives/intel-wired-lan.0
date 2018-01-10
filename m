From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Jan 2018 08:14:00 -0800
Subject: [Intel-wired-lan] PROBLEM: Uneven load distribution between
 bonded interfaces during peak load
In-Reply-To: <D7B04AEA27377C4D8A3483B9A43292A014FFB9CC@ex01.rutube.corp>
References: <D7B04AEA27377C4D8A3483B9A43292A014FFB9CC@ex01.rutube.corp>
Message-ID: <CAKgT0UefQG1d8CZzZim4yNrgj6ixmbzwd-FhCGw2JftGLv_Kmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 10, 2018 at 12:20 AM, ????????? ???????
<nsvechkarev@gazprom-media.tech> wrote:
> PROBLEM: Uneven load distribution between bonded interfaces during peak load
>
> We have encountered strange behaviour on part of the network subsystem on
> our servers. We have a number of machines serving primarily as nginx cache
> servers with 5 two-port 10G NICs (100G in total). All interfaces are
> aggregated into a single bond. The IXGBE driver is configured so that
> interrupts from every interface are distributed to several dedicated CPU
> cores. If the bond interface is configured with mode=802.3ad and
> xmit_hash_policy=layer3+4, which is convenient due to the specifics of our
> network administration, at peak load (around 70Gbit per server on average)
> the distribution of traffic between bonded interfaces, as well as of
> interrupts between CPU cores, rapidly becomes uneven (as demonstrated by
> fig. 1) and stays that way until the load drops to more manageable levels.
> If the bond is configured to use round-robin (mode=balance-rr) instead, this
> problem does not occur, as demonstrated by the same machine on fig. 2.

Have you checked your network for any other bottle-necks? The behavior
you are seeing wouldn't be inconsistent with load balancing
differences due to the TCP congestion control algorthim encountering
some sort of choke point. Normally what will happen is that some TCP
flows will become starved while others will get to use more of the
link. The fact that this doesn't manifest until you have over 80Gb/s
in total throughput points toward something like that. If nothing else
you might try eliminating two more ports to see if that causes the
remaining 8 ports to be fully utilized.

The load balancing itself for the bonding will never truly be perfect
when the flows themselves can control how much traffic goes over a
given interface. Round robin will come pretty close in terms of
loading the NICs, however you will still see certain TCP flows being
starved versus others. With the 802.3ad mode you will see that
behavior manifest at the NIC level due to the hashing, whereas with
balance-rr that will only occur with the TCP flows themselves.

Thanks.

- Alex
