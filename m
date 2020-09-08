From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 8 Sep 2020 10:24:38 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 0/6] xsk: exit NAPI loop when
 AF_XDP Rx ring is full
In-Reply-To: <8f698ac5-916f-9bb0-cce2-f00fba6ba407@intel.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
 <20200904162751.632c4443@carbon>
 <27e05518-99c6-15e2-b801-cbc0310630ef@intel.com>
 <20200904165837.16d8ecfd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1d2e781e-b26d-4cf0-0178-25b8835dbe26@intel.com>
 <20200907114055.27c95483@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <8f698ac5-916f-9bb0-cce2-f00fba6ba407@intel.com>
Message-ID: <20200908102438.28351aab@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 8 Sep 2020 08:58:30 +0200 Bj?rn T?pel wrote:
> >> As for this patch set, I think it would make sense to pull it in since
> >> it makes the single-core scenario *much* better, and it is pretty
> >> simple. Then do the application polling as another, potentially,
> >> improvement series.  
> > 
> > Up to you, it's extra code in the driver so mostly your code to
> > maintain.
> > 
> > I think that if we implement what I described above - everyone will
> > use that on a single core setup, so this set would be dead code
> > (assuming RQ is sized appropriately). But again, your call :)
> 
> Now, I agree that the busy-poll you describe above would be the best
> option, but from my perspective it's a much larger set that involves
> experimenting. I will explore that, but I still think this series should
> go in sooner to make the single core scenario usable *today*.
> 
> Ok, back to the busy-poll ideas. I'll call your idea "strict busy-poll",
> i.e. the NAPI loop is *only* driven by userland, and interrupts stay
> disabled. "Syscall driven poll-mode driver". :-)
> 
> On the driver side (again, only talking Intel here, since that's what I
> know the details of), the NAPI context would only cover AF_XDP queues,
> so that other queues are not starved.
> 
> Any ideas how strict busy-poll would look, API/implmentation-wise? An
> option only for AF_XDP sockets? Would this make sense to regular
> sockets? If so, maybe extend the existing NAPI busy-poll with a "strict"
> mode?

For AF_XDP and other sockets I think it should be quite straightforward.

For AF_XDP just implement current busy poll.

Then for all socket types add a new sockopt which sets "timeout" on how
long the IRQs can be suppressed for (we don't want application crash or
hang to knock the system off the network), or just enables the feature
and the timeout is from a sysctl.

Then make sure that at the end of polling napi doesn't get scheduled,
and set some bit which will prevent napi_schedule_prep() from letting
normal IRQ processing from scheduling it, too. Set a timer for the
timeout handling to undo all this.

What I haven't figured out in my head is how/if this relates to the
ongoing wq/threaded NAPI polling work ? but that shouldn't stop you.

> I'll start playing around a bit, but again, I think this simple series
> should go in just to make AF_XDP single core usable *today*.

No objection from me.
