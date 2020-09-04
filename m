From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Fri, 4 Sep 2020 17:39:17 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 3/6] xsk: introduce
 xsk_do_redirect_rx_full() helper
In-Reply-To: <20200904171143.5868999a@carbon>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
 <20200904135332.60259-4-bjorn.topel@gmail.com>
 <20200904171143.5868999a@carbon>
Message-ID: <dfa75afc-ceb7-76ce-6ba3-3b89c53f92f3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-09-04 17:11, Jesper Dangaard Brouer wrote:
> On Fri,  4 Sep 2020 15:53:28 +0200 Bj?rn T?pel
> <bjorn.topel@gmail.com> wrote:
> 
>> From: Bj?rn T?pel <bjorn.topel@intel.com>
>> 
>> The xsk_do_redirect_rx_full() helper can be used to check if a
>> failure of xdp_do_redirect() was due to the AF_XDP socket had a
>> full Rx ring.
> 
> This is very AF_XDP specific.  I think that the cpumap could likely 
> benefit from similar approach? e.g. if the cpumap kthread is
> scheduled on the same CPU.
> 

At least I thought this was *very* AF_XDP specific, since the kernel is
dependent of that userland runs. Allocation (source) and Rx ring (sink).
Maybe I was wrong! :-)

The thing with AF_XDP zero-copy, is that we sort of assume that if a
user enabled that most packets will have XDP_REDIRECT to an AF_XDP socket.


> But for cpumap we only want this behavior if sched on the same CPU
> as RX-NAPI.  This could be "seen" by the cpumap code itself in the
> case bq_flush_to_queue() drops packets, check if rcpu->cpu equal 
> smp_processor_id().  Maybe I'm taking this too far?
> 

Interesting. So, if you're running on the same core, and redirect fail
for CPUMAP, you'd like to yield the NAPI loop? Is that really OK from a
fairness perspective? I mean, with AF_XDP zero-copy we pretty much know
that all actions will be redirect to socket. For CPUMAP type of
applications, can that assumption be made?


Bj?rn

