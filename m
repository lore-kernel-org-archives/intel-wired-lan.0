From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 6 Jul 2021 19:54:48 +0000
Subject: [Intel-wired-lan] [net-next 04/13] ice: restart periodic
 outputs around time changes
In-Reply-To: <29cb4977-3559-094c-cc18-d2d32819e227@molgen.mpg.de>
References: <20210701002713.3486336-1-jacob.e.keller@intel.com>
 <20210701002713.3486336-5-jacob.e.keller@intel.com>
 <29cb4977-3559-094c-cc18-d2d32819e227@molgen.mpg.de>
Message-ID: <f1e78a778b994402b0a85ad59592a426@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Monday, July 05, 2021 12:52 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [net-next 04/13] ice: restart periodic outputs around
> time changes
> 
> Dear Jacob,
> 
> 
> Am 01.07.21 um 02:27 schrieb Jacob Keller:
> > Wen we enabled auxiliary input/output support for the E810 device, we
> 
> When
> 
> > forgot to add logic to restart the output when we change time. This is
> > important as the periodic output will be incorrect after a time change
> > otherwise.
> >
> > This unfortunately includes the adjust time function, even though it
> > uses an atomic hardware interface. The atomic adjustment can still cause
> > the pin output to stall permanently, so we need to stop and restart it.
> >
> > Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_ptp.c | 30 ++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > index 83ba0bf2817a..08acdb2494ed 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > @@ -776,6 +776,7 @@ ice_ptp_settime64(struct ptp_clock_info *info, const
> struct timespec64 *ts)
> >   	struct ice_pf *pf = ptp_info_to_pf(info);
> >   	struct timespec64 ts64 = *ts;
> >   	struct ice_hw *hw = &pf->hw;
> > +	u8 i;
> 
> For count variables, it?s better to use native types, size_t/unsigned
> int in this case.
> 

Sure.

>      static int ice_ptp_cfg_clkout(struct ice_pf *pf, unsigned int chan,
>                                    struct ice_perout_channel *config,
> bool store)
> 
> >   	int err;
> >
> >   	if (!ice_ptp_lock(hw)) {
> > @@ -783,12 +784,22 @@ ice_ptp_settime64(struct ptp_clock_info *info, const
> struct timespec64 *ts)
> >   		goto exit;
> >   	}
> >
> > +	/* Disable periodic outputs */
> > +	for (i = 0; i < info->n_per_out; i++)
> > +		if (pf->ptp.perout_channels[i].ena)
> > +			ice_ptp_cfg_clkout(pf, i, NULL, false);
> > +
> >   	err = ice_ptp_write_init(pf, &ts64);
> >   	ice_ptp_unlock(hw);
> >
> >   	if (!err)
> >   		ice_ptp_update_cached_phctime(pf);
> >
> > +	/* Reenable periodic outputs */
> > +	for (i = 0; i < info->n_per_out; i++)
> > +		if (pf->ptp.perout_channels[i].ena)
> > +			ice_ptp_cfg_clkout(pf, i, &pf->ptp.perout_channels[i],
> > +					   false);
> >   exit:
> >   	if (err) {
> >   		dev_err(ice_pf_to_dev(pf), "PTP failed to set time %d\n", err);
> > @@ -825,6 +836,7 @@ static int ice_ptp_adjtime(struct ptp_clock_info *info,
> s64 delta)
> >   	struct ice_hw *hw = &pf->hw;
> >   	struct device *dev;
> >   	int err;
> > +	u8 i;
> >
> >   	dev = ice_pf_to_dev(pf);
> >
> > @@ -842,8 +854,19 @@ static int ice_ptp_adjtime(struct ptp_clock_info *info,
> s64 delta)
> >   		return -EBUSY;
> >   	}
> >
> > +	/* Disable periodic outputs */
> > +	for (i = 0; i < info->n_per_out; i++)
> > +		if (pf->ptp.perout_channels[i].ena)
> > +			ice_ptp_cfg_clkout(pf, i, NULL, false);
> > +
> >   	err = ice_ptp_write_adj(pf, delta);
> >
> > +	/* Reenable periodic outputs */
> > +	for (i = 0; i < info->n_per_out; i++)
> > +		if (pf->ptp.perout_channels[i].ena)
> > +			ice_ptp_cfg_clkout(pf, i, &pf->ptp.perout_channels[i],
> > +					   false);
> > +
> >   	ice_ptp_unlock(hw);
> >
> >   	if (err) {
> > @@ -1526,6 +1549,8 @@ void ice_ptp_init(struct ice_pf *pf)
> >    */
> >   void ice_ptp_release(struct ice_pf *pf)
> >   {
> > +	int i;
> > +
> >   	/* Disable timestamping for both Tx and Rx */
> >   	ice_ptp_cfg_timestamp(pf, false);
> >
> > @@ -1543,6 +1568,11 @@ void ice_ptp_release(struct ice_pf *pf)
> >   	if (!pf->ptp.clock)
> >   		return;
> >
> > +	/* Disable periodic outputs */
> > +	for (i = 0; i < pf->ptp.info.n_per_out; i++)
> > +		if (pf->ptp.perout_channels[i].ena)
> > +			ice_ptp_cfg_clkout(pf, i, NULL, false);
> > +
> 
> Could this be put into a dedicated enable/disable function (only pf
> seems to be needed to be passed).
> 

Yea that seems like a good cleanup.

> >   	ice_clear_ptp_clock_index(pf);
> >   	ptp_clock_unregister(pf->ptp.clock);
> >   	pf->ptp.clock = NULL;
> 
> 
> Kind regards,
> 
> Paul
