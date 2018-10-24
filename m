From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 24 Oct 2018 17:51:49 +0000
Subject: [Intel-wired-lan] [PATCH v1] e1000e: allow non-monotonic SYSTIM
 readings
In-Reply-To: <20181024094616.GC12019@localhost>
References: <20181023123739.12489-1-mlichvar@redhat.com>
 <02874ECE860811409154E81DA85FBB5884CE17CD@ORSMSX115.amr.corp.intel.com>
 <20181024094616.GC12019@localhost>
Message-ID: <02874ECE860811409154E81DA85FBB5884CE318B@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Miroslav Lichvar [mailto:mlichvar at redhat.com]
> Sent: Wednesday, October 24, 2018 2:46 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; Richard Cochran <richardcochran@gmail.com>
> Subject: Re: [PATCH v1] e1000e: allow non-monotonic SYSTIM readings
> 
> > Weird issue, but I think this is a better solution than returning garbage time data
> like we were before.
> 
> It is indeed a weird issue. I think one explanation could be a double
> overflow of SYSTIML with the unreliable latching of SYSTIMH.
> 

Makes some sense.

> If my math is right, depending on the frequency of the clock the
> SYSTIML register overflows about every 8, 16, or 262 microseconds.
> That seems too short to reliably contain reading of two registers.
> 

Right. In theory the hardware is supposed to be latching the values, but we know that's problematic on some of the parts in this driver.

> Let's say the first reading of SYSMTIML is 0xffff0000 and the second
> reading is 0xff000000. An overflow is detected. But before SYSTIMH is
> read for the second time, another overflow may happen, which will
> cause the returned time to be ahead of the true PHC time and the next
> correct reading may be out-of-order.
> 

Right.

> I'm wondering whether the commit 37b12910 ("e1000e: Fix tight loop
> implementation of systime read algorithm") made this more likely to
> happen (if it really is what happens).

If your analysis is correct, that makes sense.

> 
> The best fix might be to use a much smaller INCVALUE, so that the
> double overflow cannot happen, and implement the frequency adjustment
> in software, similarly to the system clock. This could be reused in
> other drivers that don't support a one-step clock in order to simplify
> their code.
> 

This makes sense. Especially since we already use a timecounter, we already don't report exactly what the hardware register indicates. This can be confusing if using hardware timer controls, or if some setup tries to read timestamps out-of-band from the PTP clock interface. But I don't think that's a major concern if we're already using a timecounter.

Thanks,
Jake

> --
> Miroslav Lichvar
