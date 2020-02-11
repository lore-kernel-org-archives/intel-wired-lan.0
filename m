From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 11 Feb 2020 22:20:25 +0000
Subject: [Intel-wired-lan] [PATCH S39 01/15] ice: Validate config for SW
 DCB map
In-Reply-To: <5cea01f5-7e1b-f835-60b3-2dafa8b6e744@molgen.mpg.de>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
 <5cea01f5-7e1b-f835-60b3-2dafa8b6e744@molgen.mpg.de>
Message-ID: <69197e331233673ea185bd5d48f9773ee72bf45e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2020-02-11 at 18:07 +0100, Paul Menzel wrote:
> Dear Tony,
> 
> 
> On 2020-01-27 09:59, Tony Nguyen wrote:
> > From: Avinash Dayanand <avinash.dayanand@intel.com>
> > 
> > Validate the inputs for SW DCB config received either via lldptool
> > or pcap
> > file. And don't apply DCB for bad bandwidth inputs or non-
> > contiguous TCs.
> > Without this patch, any config having bad inputs will cause the
> > loss of
> > link making PF unusable even after driver reload. Recoverable only
> > via
> > system reboot.
> > 
> > Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 55
> > ++++++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  1 +
> >  drivers/net/ethernet/intel/ice/ice_dcb_nl.c  |  7 +++
> >  3 files changed, 63 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> > b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> > index 0f4ca813a7ab..bd361212921c 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> > @@ -169,6 +169,56 @@ ice_peer_prep_tc_change(struct
> > ice_peer_dev_int *peer_dev_int,
> >  	return 0;
> >  }
> >  
> > +/**
> > + * ice_dcb_bwchk - check if ETS bandwidth input parameters are
> > correct
> > + * @dcbcfg: pointer to DCB config structure
> > + */
> > +int ice_dcb_bwchk(struct ice_dcbx_cfg *dcbcfg)
> > +{
> > +	struct ice_dcb_ets_cfg *etscfg = &dcbcfg->etscfg;
> > +	u8 num_tc, total_bw = 0;
> > +	int i;
> > +
> > +	/* returns number of contigous TCs and 1 TC for non-contigous
> > TCs,
> > +	 * since at least 1 TC has to be configured
> > +	 */
> > +	num_tc = ice_dcb_get_num_tc(dcbcfg);
> > +
> > +	/* no bandwidth checks required if there's only one TC and
> > assign
> > +	 * all bandwidth to it i.e. to TC0 and return
> 
> ?, so assign all bandwidth to TC0 and return
> 

Will fix the comment to include this

> > +	 */
> > +	if (num_tc == 1) {
> > +		etscfg->tcbwtable[0] = ICE_TC_MAX_BW;
> > +		return 0;
> > +	}
> > +	/* There are few rules with which TC bandwidth can be applied
> > for any TC
> > +	 * with a UP mapped to it.
> > +	 *	1. All TCs have zero BW - Valid
> > +	 *	   ex:  tcbw=0,0,0
> > +	 *	2. First few non-zero and rest zero BW - Valid
> > +	 *	   ex:  tcbw=100,0,0
> > +	 *	3. Zero BW in between 2 non-zero BW TCs - Invalid
> > +	 *	   ex:  tcbw=25,0,75
> > +	 */
> > +	for (i = 0; i < num_tc; i++) {
> > +		/* don't allow zero BW for TCs other than TC0 */
> > +		if (i && !etscfg->tcbwtable[i])
> > +			goto err;
> 
> As the error handling is just `return -EINVAL`, please do that
> directly
> here.

After talking to others this check is not needed so I'll take it out
altogether.

> > +
> > +		if (etscfg->tsatable[i] == ICE_IEEE_TSA_ETS)
> > +			total_bw += etscfg->tcbwtable[i];
> > +	}
> > +
> > +	 /* total bandwidth should be equal to 100 */
> > +	if (total_bw != ICE_TC_MAX_BW)
> > +		goto err;
> 
> Ditto.
> 
> Also, why not print an error for this case?

Will do both.

> > +
> > +	return 0;
> > +
> > +err:
> > +	return -EINVAL;
> > +}
> > +
> >  /**
> >   * ice_pf_dcb_cfg - Apply new DCB configuration
> >   * @pf: pointer to the PF struct
> > @@ -206,6 +256,11 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct
> > ice_dcbx_cfg *new_cfg, bool locked)
> >  	/* Notify capable peers about impending change to TCs */
> >  	ice_for_each_peer(pf, NULL, ice_peer_prep_tc_change);
> >  
> > +	if (ice_dcb_bwchk(new_cfg)) {
> > +		dev_err(dev, "Invalid config, not applying DCB\n");
> 
> It?d be useful to know what is incorrect. So, maybe move the error
> message
> into the function.

Will include messaging in the function on what is incorrect.

> 
> > +		return -EINVAL;
> > +	}
> > +
> >  	/* Store old config in case FW config fails */
> >  	old_cfg = kmemdup(curr_cfg, sizeof(*old_cfg), GFP_KERNEL);
> >  	if (!old_cfg)
> > diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
> > b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
> > index bb53edf462ba..2b900da27f57 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
> > @@ -20,6 +20,7 @@ u8 ice_dcb_get_num_tc(struct ice_dcbx_cfg
> > *dcbcfg);
> >  u8 ice_dcb_get_tc(struct ice_vsi *vsi, int queue_index);
> >  int
> >  ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg,
> > bool locked);
> > +int ice_dcb_bwchk(struct ice_dcbx_cfg *dcbcfg);
> >  void ice_pf_dcb_recfg(struct ice_pf *pf);
> >  void ice_vsi_cfg_dcb_rings(struct ice_vsi *vsi);
> >  int ice_init_pf_dcb(struct ice_pf *pf, bool locked);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
> > b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
> > index b61aba428adb..a45e8abef8f3 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
> > @@ -95,6 +95,12 @@ static int ice_dcbnl_setets(struct net_device
> > *netdev, struct ieee_ets *ets)
> >  		new_cfg->etsrec.prio_table[i] = ets->reco_prio_tc[i];
> >  	}
> >  
> > +	if (ice_dcb_bwchk(new_cfg)) {
> > +		netdev_err(netdev, "Invalid config, not applying
> > DCB\n");
> > +		err = -EINVAL;
> > +		goto ets_out;
> 
> Is that good style to use goto in this case? Why can?t it be put
> after
> `ice_pf_dcb_cfg()`?

We need to validate the config before applying it, which is what
ice_pf_dcb_cfg() does. We can't apply the config without knowing that
it's a good configuration.

For the goto, we're trying to have a single point of unlock/exit.

Thanks,
Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3277 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200211/1255c25f/attachment.bin>
