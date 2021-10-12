From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 12 Oct 2021 00:58:08 +0000
Subject: [Intel-wired-lan] [net-next PATCH 9/9] ice: support
 crosstimestamping on E822 devices if supported
In-Reply-To: <87mtnfhz21.fsf@linux.intel.com>
References: <20211011215433.1525457-1-jacob.e.keller@intel.com>
 <20211011215433.1525457-10-jacob.e.keller@intel.com>
 <87mtnfhz21.fsf@linux.intel.com>
Message-ID: <CO1PR11MB5089AC81D4843D4F7D50A00FD6B69@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Gomes, Vinicius <vinicius.gomes@intel.com>
> Sent: Monday, October 11, 2021 5:23 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Intel Wired LAN <intel-wired-
> lan at lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [net-next PATCH 9/9] ice: support
> crosstimestamping on E822 devices if supported
> 
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
> > E822 devices on supported platforms can generate a cross timestamp
> > between the platform ART and the device time. This process allows for
> > very precise measurement of the difference between the PTP hardware
> > clock and the platform time.
> >
> > This is only supported if we know the TSC frequency relative to ART, so
> > we do not enable this unless the boot CPU has a known TSC frequency (as
> > required by convert_art_ns_to_tsc).
> >
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> >  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   8 ++
> >  drivers/net/ethernet/intel/ice/ice_ptp.c      | 113 ++++++++++++++++++
> >  2 files changed, 121 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> > index 7bff0450b76c..d16738a3d3a7 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> > @@ -441,6 +441,10 @@
> >  #define GLV_UPRCL(_i)				(0x003B2000 + ((_i) * 8))
> >  #define GLV_UPTCL(_i)				(0x0030A000 + ((_i) * 8))
> >  #define PRTRPB_RDPC				0x000AC260
> > +#define GLHH_ART_CTL				0x000A41D4
> > +#define GLHH_ART_CTL_ACTIVE_M			BIT(0)
> > +#define GLHH_ART_TIME_H				0x000A41D8
> > +#define GLHH_ART_TIME_L				0x000A41DC
> >  #define GLTSYN_AUX_IN_0(_i)			(0x000889D8 + ((_i) * 4))
> >  #define GLTSYN_AUX_IN_0_INT_ENA_M		BIT(4)
> >  #define GLTSYN_AUX_OUT_0(_i)			(0x00088998 + ((_i) * 4))
> > @@ -453,6 +457,8 @@
> >  #define GLTSYN_ENA_TSYN_ENA_M			BIT(0)
> >  #define GLTSYN_EVNT_H_0(_i)			(0x00088970 + ((_i) * 4))
> >  #define GLTSYN_EVNT_L_0(_i)			(0x00088968 + ((_i) * 4))
> > +#define GLTSYN_HHTIME_H(_i)			(0x00088900 + ((_i) * 4))
> > +#define GLTSYN_HHTIME_L(_i)			(0x000888F8 + ((_i) * 4))
> >  #define GLTSYN_INCVAL_H(_i)			(0x00088920 + ((_i) * 4))
> >  #define GLTSYN_INCVAL_L(_i)			(0x00088918 + ((_i) * 4))
> >  #define GLTSYN_SHADJ_H(_i)			(0x00088910 + ((_i) * 4))
> > @@ -469,6 +475,8 @@
> >  #define GLTSYN_TGT_L_0(_i)			(0x00088928 + ((_i) * 4))
> >  #define GLTSYN_TIME_H(_i)			(0x000888D8 + ((_i) * 4))
> >  #define GLTSYN_TIME_L(_i)			(0x000888D0 + ((_i) * 4))
> > +#define PFHH_SEM				0x000A4200 /* Reset Source: PFR
> */
> > +#define PFHH_SEM_BUSY_M				BIT(0)
> >  #define PFTSYN_SEM				0x00088880
> >  #define PFTSYN_SEM_BUSY_M			BIT(0)
> >  #define VSIQF_FD_CNT(_VSI)			(0x00464000 + ((_VSI) * 4))
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > index 047914111389..ea853a744376 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > @@ -1598,6 +1598,99 @@ static int ice_ptp_adjtime(struct ptp_clock_info
> *info, s64 delta)
> >  	return 0;
> >  }
> >
> > +/**
> > + * ice_ptp_get_syncdevicetime - Get the cross time stamp info
> > + * @device: Current device time
> > + * @system: System counter value read synchronously with device time
> > + * @ctx: Context provided by timekeeping code
> > + *
> > + * Read device and system (ART) clock simultaneously and return the
> corrected
> > + * clock values in ns.
> > + */
> > +static int
> > +ice_ptp_get_syncdevicetime(ktime_t *device,
> > +			   struct system_counterval_t *system,
> > +			   void *ctx)
> > +{
> > +	struct ice_pf *pf = (struct ice_pf *)ctx;
> > +	struct ice_hw *hw = &pf->hw;
> > +	u32 hh_lock, hh_art_ctl;
> > +	int i;
> > +
> > +	/* Get the HW lock */
> > +	hh_lock = rd32(hw, PFHH_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
> > +	if (hh_lock & PFHH_SEM_BUSY_M) {
> > +		dev_err(ice_pf_to_dev(pf), "PTP failed to get hh lock\n");
> > +		return -EFAULT;
> > +	}
> > +
> > +	/* Start the ART and device clock sync sequence */
> > +	hh_art_ctl = rd32(hw, GLHH_ART_CTL);
> > +	hh_art_ctl = hh_art_ctl | GLHH_ART_CTL_ACTIVE_M;
> > +	wr32(hw, GLHH_ART_CTL, hh_art_ctl);
> > +
> > +#define MAX_HH_LOCK_TRIES 100
> > +
> > +	for (i = 0; i < MAX_HH_LOCK_TRIES; i++) {
> > +		/* Wait for sync to complete */
> > +		hh_art_ctl = rd32(hw, GLHH_ART_CTL);
> > +		if (hh_art_ctl & GLHH_ART_CTL_ACTIVE_M) {
> > +			udelay(1);
> > +			continue;
> > +		} else {
> > +			u32 hh_ts_lo, hh_ts_hi, tmr_idx;
> > +			u64 hh_ts;
> > +
> > +			tmr_idx = hw->func_caps.ts_func_info.tmr_index_assoc;
> > +			/* Read ART time */
> > +			hh_ts_lo = rd32(hw, GLHH_ART_TIME_L);
> > +			hh_ts_hi = rd32(hw, GLHH_ART_TIME_H);
> > +			hh_ts = ((u64)hh_ts_hi << 32) | hh_ts_lo;
> > +			*system = convert_art_ns_to_tsc(hh_ts);
> 
> Note that convert_art_ns_to_tsc() is only defined for x86, will not
> compile for others.
> 
> For igc, I wrote a very simple wrapper, if you have better suggestions I
> also would like to hear :-)
> 

I must have accidentally grabbed an out-of-date version of the series. This should have included the ICE_HWTS config option which disables this support except for X86

I'll resend with the fixed patch and double check all of the other fixes from previous versions made it in as well..

Thanks,
Jake


