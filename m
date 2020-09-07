From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 7 Sep 2020 11:40:55 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 0/6] xsk: exit NAPI loop when
 AF_XDP Rx ring is full
In-Reply-To: <1d2e781e-b26d-4cf0-0178-25b8835dbe26@intel.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
 <20200904162751.632c4443@carbon>
 <27e05518-99c6-15e2-b801-cbc0310630ef@intel.com>
 <20200904165837.16d8ecfd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1d2e781e-b26d-4cf0-0178-25b8835dbe26@intel.com>
Message-ID: <20200907114055.27c95483@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 7 Sep 2020 15:37:40 +0200 Bj?rn T?pel wrote:
>  > I've been pondering the exact problem you're solving with Maciej
>  > recently. The efficiency of AF_XDP on one core with the NAPI processing.
>  >
>  > Your solution (even though it admittedly helps, and is quite simple)
>  > still has the application potentially not able to process packets
>  > until the queue fills up. This will be bad for latency.
>  >
>  > Why don't we move closer to application polling? Never re-arm the NAPI
>  > after RX, let the application ask for packets, re-arm if 0 polled.
>  > You'd get max batching, min latency.
>  >
>  > Who's the rambling one now? :-D
>  >  
> 
> :-D No, these are all very good ideas! We've actually experimented
> with it with the busy-poll series a while back -- NAPI busy-polling
> does exactly "application polling".
> 
> However, I wonder if the busy-polling would have better performance
> than the scenario above (i.e. when the ksoftirqd never kicks in)?
> Executing the NAPI poll *explicitly* in the syscall, or implicitly
> from the softirq.
> 
> Hmm, thinking out loud here. A simple(r) patch enabling busy poll;
> Exporting the napi_id to the AF_XDP socket (xdp->rxq->napi_id to
> sk->sk_napi_id), and do the sk_busy_poll_loop() in sendmsg.
> 
> Or did you have something completely different in mind?

My understanding is that busy-polling is allowing application to pick
up packets from the ring before the IRQ fires.

What we're more concerned about is the IRQ firing in the first place.

 application:   busy    | needs packets | idle
 -----------------------+---------------+----------------------
   standard   |         |   polls NAPI  | keep polling? sleep?
   busy poll  | IRQ on  |    IRQ off    |  IRQ off      IRQ on
 -------------+---------+---------------+----------------------
              |         |   polls once  |
    AF_XDP    | IRQ off |    IRQ off    |  IRQ on


So busy polling is pretty orthogonal. It only applies to the
"application needs packets" time. What we'd need is for the application
to be able to suppress NAPI polls, promising the kernel that it will
busy poll when appropriate.

> As for this patch set, I think it would make sense to pull it in since
> it makes the single-core scenario *much* better, and it is pretty
> simple. Then do the application polling as another, potentially,
> improvement series.

Up to you, it's extra code in the driver so mostly your code to
maintain.

I think that if we implement what I described above - everyone will
use that on a single core setup, so this set would be dead code
(assuming RQ is sized appropriately). But again, your call :)
