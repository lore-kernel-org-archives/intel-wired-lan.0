From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 26 Sep 2019 17:42:33 +0000
Subject: [Intel-wired-lan] [net-next v2 2/2] net: reject ptp requests
 with unsupported flags
In-Reply-To: <20190926040222.GB21883@localhost>
References: <20190926022820.7900-1-jacob.e.keller@intel.com>
 <20190926022820.7900-3-jacob.e.keller@intel.com>
 <20190926040222.GB21883@localhost>
Message-ID: <02874ECE860811409154E81DA85FBB58968D86CB@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org] On
> Behalf Of Richard Cochran
> Sent: Wednesday, September 25, 2019 9:02 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: netdev at vger.kernel.org; Intel Wired LAN <intel-wired-lan@lists.osuosl.org>;
> Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Felipe Balbi
> <felipe.balbi@linux.intel.com>; David S . Miller <davem@davemloft.net>; Hall,
> Christopher S <christopher.s.hall@intel.com>
> Subject: Re: [net-next v2 2/2] net: reject ptp requests with unsupported flags
> 
> On Wed, Sep 25, 2019 at 07:28:20PM -0700, Jacob Keller wrote:
> > This patch may not be correct for individual drivers, especially
> > regarding the rising vs falling edge flags. I interpreted the default
> > behavior to be to timestamp the rising edge of a pin transition.
> 
> So I think this patch goes too far.  It breaks the implied ABI.
> 
> > diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c
> b/drivers/net/ethernet/intel/igb/igb_ptp.c
> > index fd3071f55bd3..2867a2581a36 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> > @@ -521,6 +521,10 @@ static int igb_ptp_feature_enable_i210(struct
> ptp_clock_info *ptp,
> >
> >  	switch (rq->type) {
> >  	case PTP_CLK_REQ_EXTTS:
> > +		/* Reject requests with unsupported flags */
> > +		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE | PTP_RISING_EDGE))
> > +			return -EOPNOTSUPP;
> 
> This HW always time stamps both edges, and that is not configurable.
> Here you reject PTP_FALLING_EDGE, and that is clearly wrong.  If the
> driver had been really picky (my fault I guess), it should have always
> insisted on (PTP_RISING_EDGE | PTP_FALLING_EDGE) being set together.
> But it is too late to enforce that now, because it could break user
> space programs.
> 
> I do agree with the sentiment of checking the flags at the driver
> level, but this needs to be done case by case, with the drivers'
> author's input.
> 
> (The req.perout.flags can be done unconditionally in all drivers,
> since there were never any valid flags, but req.extts.flags needs
> careful attention.)
> 
> Thanks,
> Richard

I will split this patch apart and make the extts part per-driver.

Thanks,
Jake
