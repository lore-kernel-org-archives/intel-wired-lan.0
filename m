From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Mon, 29 Oct 2018 14:31:09 +0100
Subject: [Intel-wired-lan] [RFC PATCH 4/4] ixgbe: add support for
 extended PHC gettime
In-Reply-To: <02874ECE860811409154E81DA85FBB5884CE4B8C@ORSMSX115.amr.corp.intel.com>
References: <20181026162742.631-1-mlichvar@redhat.com>
 <20181026162742.631-5-mlichvar@redhat.com>
 <02874ECE860811409154E81DA85FBB5884CE4B8C@ORSMSX115.amr.corp.intel.com>
Message-ID: <20181029133109.GD31668@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 26, 2018 at 04:54:57PM +0000, Keller, Jacob E wrote:
> > -----Original Message-----
> > From: Miroslav Lichvar [mailto:mlichvar at redhat.com]
> > Sent: Friday, October 26, 2018 9:28 AM
> > To: netdev at vger.kernel.org
> > Cc: intel-wired-lan at lists.osuosl.org; Richard Cochran <richardcochran@gmail.com>;
> > Keller, Jacob E <jacob.e.keller@intel.com>; Miroslav Lichvar <mlichvar@redhat.com>
> > Subject: [RFC PATCH 4/4] ixgbe: add support for extended PHC gettime
> > 
> > Cc: Richard Cochran <richardcochran@gmail.com>
> > Cc: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>

> What about replacing gettime64 with:
> 
> static int ixgbe_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts)
> {
>     struct ptp_system_timestamp sts
>     
>     ixgbe_ptp_gettimex(ptp, &tst);
>     *ts = sts.phc_ts
> }

That will work, but it will be slower. With HPET as a clocksource
there would be few microseconds of an extra (symmetric) delay and the
applications would have to assume a larger maximum error.

I think there could be a flag in ptp_system_timestamp, or a parameter
of gettimex64(), which would enable/disable reading of the system
clock.

> Actually, could that even just be provided by the PTP core if gettime64 isn't implemented? This way new drivers only have to implement the new interface, and userspace will just get the old behavior if they use the old call?

Good idea.

Thanks,

-- 
Miroslav Lichvar
