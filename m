From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Thu, 10 Dec 2020 18:30:23 +0100
Subject: [Intel-wired-lan] Explaining XDP redirect bulk size design
 (Was: [PATCH v2 bpf 1/5] net: ethtool: add xdp properties flag set)
In-Reply-To: <CAJ8uoz25rtO63-4nOSV-yr8bORNbNSquiBBWiEouLs-ZUv2o=A@mail.gmail.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com>
 <878sad933c.fsf@toke.dk>
 <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <20201207135433.41172202@carbon>
 <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
 <20201207230755.GB27205@ranger.igk.intel.com>
 <5fd068c75b92d_50ce20814@john-XPS-13-9370.notmuch>
 <20201209095454.GA36812@ranger.igk.intel.com>
 <20201209125223.49096d50@carbon>
 <6913010d-2fd6-6713-94e9-8f5b8ad4b708@gmail.com>
 <20201210143211.2490f7f4@carbon>
 <CAJ8uoz25rtO63-4nOSV-yr8bORNbNSquiBBWiEouLs-ZUv2o=A@mail.gmail.com>
Message-ID: <20201210183023.4b299334@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 10 Dec 2020 15:14:18 +0100
Magnus Karlsson <magnus.karlsson@gmail.com> wrote:

> On Thu, Dec 10, 2020 at 2:32 PM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> >
> > On Wed, 9 Dec 2020 08:44:33 -0700
> > David Ahern <dsahern@gmail.com> wrote:
> >  
> > > On 12/9/20 4:52 AM, Jesper Dangaard Brouer wrote:  
> > > > But I have redesigned the ndo_xdp_xmit call to take a bulk of packets
> > > > (up-to 16) so it should not be a problem to solve this by sharing
> > > > TX-queue and talking a lock per 16 packets.  I still recommend that,
> > > > for fallback case,  you allocated a number a TX-queue and distribute
> > > > this across CPUs to avoid hitting a congested lock (above measurements
> > > > are the optimal non-congested atomic lock operation)  
> > >
> > > I have been meaning to ask you why 16 for the XDP batching? If the
> > > netdev budget is 64, why not something higher like 32 or 64?  
> >
> > Thanks you for asking as there are multiple good reasons and
> > consideration for this 16 batch size.  Notice cpumap have batch size 8,
> > which is also an explicit choice.  And AF_XDP went in the wrong
> > direction IMHO and I think have 256.  I designed this to be a choice in
> > the map code, for the level of bulking it needs/wants.  
> 
> FYI, as far as I know, there is nothing in AF_XDP that says bulking
> should be 256. There is a 256 number in the i40e driver that states
> the maximum number of packets to be sent within one napi_poll loop.
> But this is just a maximum number and only for that driver. (In case
> you wonder, that number was inherited from the original skb Tx
> implementation in the driver.) 

Ah, that explains the issue I have on the production system that runs
the EDT-pacer[2].  I see that i40e function i40e_clean_tx_irq() ignores
napi_budget but uses it own budget, that defaults to 256.  Looks like I
can adjust this via ethtool -C tx-frames-irq.   I turned this down to
64 (32 was giving worse results, and below 16 system acted strange).

Now the issue is gone, which was that if TX-DMA completion was running
(i40e_clean_tx_irq()) on the same CPU that send packets via FQ-pacer
qdisc, then the pacing was not accurate, and was sending too bursty.

System have already tuned "net/core/dev_weight" and RX/TX-bias to
reduce bulking, as this can influence latency and the EDT-pacing
accuracy. (It is a middlebox bridging VLANs and BPF-EDT tiemstamping and
FQ-pacing packets to solve bursts overflowing switch ports).

  sudo sysctl net/core/dev_weight
  net.core.dev_weight = 1
  net.core.dev_weight_rx_bias = 32
  net.core.dev_weight_tx_bias = 1

This net.core.dev_weight_tx_bias=1 (together with dev_weight=1) cause
qdisc transmit budget to become one packet, cycling through
NET_TX_SOFTIRQ which consumes time and gives a little more pacing space
for the packets.


> The actual batch size is controlled by
> the application. If it puts 1 packet in the Tx ring and calls send(),
> the batch size will be 1. If it puts 128 packets in the Tx ring and
> calls send(), you get a batch size of 128, and so on. It is flexible,
> so you can trade-off latency with throughput in the way the
> application desires. Rx batch size has also become flexible now with
> the introduction of Bj?rn's prefer_busy_poll patch set [1].
> 
> [1] https://lore.kernel.org/netdev/20201130185205.196029-1-bjorn.topel at gmail.com/

This looks like a cool trick, to get even more accurate packet scheduling.

I played with the tunings, and could see changed behavior with mpstat,
but ended up tuning it off again, as I could not measure a direct
correlation with the bpftrace tools[3].


> > The low level explanation is that these 8 and 16 batch sizes are
> > optimized towards cache sizes and Intel's Line-Fill-Buffer (prefetcher
> > with 10 elements).  I'm betting on that memory backing these 8 or 16
> > packets have higher chance to remain/being in cache, and I can prefetch
> > them without evicting them from cache again.  In some cases the pointer
> > to these packets are queued into a ptr_ring, and it is more optimal to
> > write cacheline sizes 1 (8 pointers) or 2 (16 pointers) into the ptr_ring.
> >
> > The general explanation is my goal to do bulking without adding latency.
> > This is explicitly stated in my presentation[1] as of Feb 2016, slide 20.
> > Sure, you/we can likely make the micro-benchmarks look better by using
> > 64 batch size, but that will introduce added latency and likely shoot
> > our-selves in the foot for real workloads.  With experience from
> > bufferbloat and real networks, we know that massive TX bulking have bad
> > effects.  Still XDP-redirect does massive bulking (NIC flush is after
> > full 64 budget) and we don't have pushback or a queue mechanism (so I
> > know we are already shooting ourselves in the foot) ...  Fortunately we
> > now have a PhD student working on queuing for XDP.
> >
> > It is also important to understand that this is an adaptive bulking
> > scheme, which comes from NAPI.  We don't wait for packets arriving
> > shortly, we pickup what NIC have available, but by only taking 8 or 16
> > packets (instead of emptying the entire RX-queue), and then spending
> > some time to send them along, I'm hoping that NIC could have gotten
> > some more frame.  For cpumap and veth (in-some-cases) they can start to
> > consume packets from these batches, but NIC drivers gets XDP_XMIT_FLUSH
> > signal at NAPI-end (xdp_do_flush). Still design allows NIC drivers to
> > update their internal queue state (and BQL), and if it gets close to
> > full they can choose to flush/doorbell the NIC earlier.  When doing
> > queuing for XDP we need to expose these NIC queue states, and having 4
> > calls with 16 packets (64 budget) also gives us more chances to get NIC
> > queue state info which the NIC already touch.
> >
> >
> > [1] https://people.netfilter.org/hawk/presentations/devconf2016/net_stack_challenges_100G_Feb2016.pdf

[2] https://github.com/netoptimizer/bpf-examples/tree/master/traffic-pacing-edt/

[3] https://github.com/netoptimizer/bpf-examples/tree/master/traffic-pacing-edt/bpftrace


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

