From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 4 Sep 2020 16:58:37 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 0/6] xsk: exit NAPI loop when
 AF_XDP Rx ring is full
In-Reply-To: <27e05518-99c6-15e2-b801-cbc0310630ef@intel.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
 <20200904162751.632c4443@carbon>
 <27e05518-99c6-15e2-b801-cbc0310630ef@intel.com>
Message-ID: <20200904165837.16d8ecfd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 4 Sep 2020 16:32:56 +0200 Bj?rn T?pel wrote:
> On 2020-09-04 16:27, Jesper Dangaard Brouer wrote:
> > On Fri,  4 Sep 2020 15:53:25 +0200
> > Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> >   
> >> On my machine the "one core scenario Rx drop" performance went from
> >> ~65Kpps to 21Mpps. In other words, from "not usable" to
> >> "usable". YMMV.  
> > 
> > We have observed this kind of dropping off an edge before with softirq
> > (when userspace process runs on same RX-CPU), but I thought that Eric
> > Dumazet solved it in 4cd13c21b207 ("softirq: Let ksoftirqd do its job").
> > 
> > I wonder what makes AF_XDP different or if the problem have come back?
> >   
> 
> I would say this is not the same issue. The problem is that the softirq 
> is busy dropping packets since the AF_XDP Rx is full. So, the cycles 
> *are* split 50/50, which is not what we want in this case. :-)
> 
> This issue is more of a "Intel AF_XDP ZC drivers does stupid work", than 
> fairness. If the Rx ring is full, then there is really no use to let the 
> NAPI loop continue.
> 
> Would you agree, or am I rambling? :-P

I wonder if ksoftirqd never kicks in because we are able to discard 
the entire ring before we run out of softirq "slice".


I've been pondering the exact problem you're solving with Maciej
recently. The efficiency of AF_XDP on one core with the NAPI processing.

Your solution (even though it admittedly helps, and is quite simple)
still has the application potentially not able to process packets 
until the queue fills up. This will be bad for latency.

Why don't we move closer to application polling? Never re-arm the NAPI 
after RX, let the application ask for packets, re-arm if 0 polled. 
You'd get max batching, min latency.

Who's the rambling one now? :-D
