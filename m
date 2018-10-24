From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Wed, 24 Oct 2018 11:46:16 +0200
Subject: [Intel-wired-lan] [PATCH v1] e1000e: allow non-monotonic SYSTIM
 readings
In-Reply-To: <02874ECE860811409154E81DA85FBB5884CE17CD@ORSMSX115.amr.corp.intel.com>
References: <20181023123739.12489-1-mlichvar@redhat.com>
 <02874ECE860811409154E81DA85FBB5884CE17CD@ORSMSX115.amr.corp.intel.com>
Message-ID: <20181024094616.GC12019@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 23, 2018 at 04:32:50PM +0000, Keller, Jacob E wrote:
> > It seems with some NICs supported by the e1000e driver a SYSTIM reading
> > may occasionally be few microseconds before the previous reading and if
> > enabled also pass e1000e_sanitize_systim() without reaching the maximum
> > number of rereads, even if the function is modified to check three
> > consecutive readings (i.e. it doesn't look like a double read error).
> > This causes an underflow in the timecounter and the PHC time jumps hours
> > ahead.
> > 
> 
> Weird issue, but I think this is a better solution than returning garbage time data like we were before.

It is indeed a weird issue. I think one explanation could be a double
overflow of SYSTIML with the unreliable latching of SYSTIMH.

If my math is right, depending on the frequency of the clock the
SYSTIML register overflows about every 8, 16, or 262 microseconds.
That seems too short to reliably contain reading of two registers.

Let's say the first reading of SYSMTIML is 0xffff0000 and the second
reading is 0xff000000. An overflow is detected. But before SYSTIMH is
read for the second time, another overflow may happen, which will
cause the returned time to be ahead of the true PHC time and the next
correct reading may be out-of-order.

I'm wondering whether the commit 37b12910 ("e1000e: Fix tight loop
implementation of systime read algorithm") made this more likely to
happen (if it really is what happens).

The best fix might be to use a much smaller INCVALUE, so that the
double overflow cannot happen, and implement the frequency adjustment
in software, similarly to the system clock. This could be reused in
other drivers that don't support a one-step clock in order to simplify
their code.

-- 
Miroslav Lichvar
