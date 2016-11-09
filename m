From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 9 Nov 2016 14:11:46 +0100
Subject: [Intel-wired-lan] [PATCH net-next 2/3] ptp: igb: Use the high
 resolution frequency method.
In-Reply-To: <1478642533.7545.38.camel@intel.com>
References: <cover.1478526333.git.richardcochran@gmail.com>
 <b1d732324e0b1960b294e90ca5eb2a31b6559188.1478526333.git.richardcochran@gmail.com>
 <1478642533.7545.38.camel@intel.com>
Message-ID: <20161109131146.GA6491@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 08, 2016 at 10:02:22PM +0000, Keller, Jacob E wrote:
> On Tue, 2016-11-08 at 22:49 +0100, Richard Cochran wrote:
> > -	rate = ppb;
> > -	rate <<= 26;
> > -	rate = div_u64(rate, 1953125);
> > +	rate = scaled_ppm;
> > +	rate <<= 13;
> > +	rate = div_u64(rate, 15625);
> 
> I'm curious how you generate the new math here, since this can be
> tricky, and I could use more examples in order to port to some of the
> other drivers implementations. I'm not quit sure how to handle the
> value when the lower 16 bits are fractional.

TL;DR version:

In ptp_clock.c we convert scaled_ppm to ppb like this.

	ppb = scaled_ppm * 10^3 * 2^-16

If you already have a working driver that does

	regval = ppb * SOMEMATH;

then just substitute

	regval = (scaled_ppm * 10^3 * 2^-16) * SOMEMATH;
	       = (scaled_ppm *  5^3 * 2^-13) * SOMEMATH;

and simplify by combining the 5^3 and 2^-13 constants into SOMEMATH.

Longer explanation:

You have to consider how the frequency adjustment HW works, case by
case.  Both the i210 and the phyter have an adjustment register that
holds units of 2^-32 nanoseconds per 8 nanosecond clock period, and so
the rate from adjustment value 1 is (2^-32 / 8).

Then with the old interface, the conversion from "adjustment unit" to
ppb was (2^-32 / 8 * 10^9) or (2^-26 * 5^9).  The conversion the other
way needs the inverse, and so the code did (ppb << 26) / 5^9.

With the new interface, the conversion from "adjustment unit" to
scaled_ppm is (2^-32 / 8 * 10^6 * 2^16) or (2^-13 * 5^6).  The code
converts the other direction using the inverse, (s_ppm << 13) / 5^6.

HTH,
Richard
