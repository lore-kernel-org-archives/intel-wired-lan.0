From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 11 Feb 2020 22:23:01 +0000
Subject: [Intel-wired-lan] [PATCH S39 09/15] ice: Don't reject odd
 values of usecs set by user
In-Reply-To: <9d07b895-938e-c013-65a5-f274a3b8dcdf@molgen.mpg.de>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
 <20200127085927.13999-9-anthony.l.nguyen@intel.com>
 <9d07b895-938e-c013-65a5-f274a3b8dcdf@molgen.mpg.de>
Message-ID: <201a8cea45b211d6a5d4257c527bf723799149d8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2020-02-11 at 18:21 +0100, Paul Menzel wrote:
> Dear Tony,
> 
> 
> On 2020-01-27 09:59, Tony Nguyen wrote:
> > From: Brett Creeley <brett.creeley@intel.com>
> > 
> > Currently if a user sets an odd [tx|rx]-usecs value through
> > ethtool,
> > the request is denied because the hardware is set to have an ITR
> > granularity of 2us. This caused poor customer experience. Fix this
> > by
> > aligning to a register allowed value, which results in rounding
> > down.
> > Also, print a once per ring container type message to be clear
> > about
> > our intentions.
> > 
> > Also, change the ITR_TO_REG define to be the bitwise and of the ITR
> > setting and the ICE_ITR_MASK. This makes the purpose of ITR_TO_REG
> > more
> > obvious.
> > 
> > Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_ethtool.c | 49 +++++++++++++++-
> > ----
> >  drivers/net/ethernet/intel/ice/ice_txrx.h    |  2 +-
> >  2 files changed, 39 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > index db14ec2e0b46..ae0b63d5673d 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > @@ -3488,21 +3488,13 @@ ice_set_rc_coalesce(enum ice_container_type
> > c_type, struct ethtool_coalesce *ec,
> >  		return -EINVAL;
> >  	}
> >  
> > -	/* hardware only supports an ITR granularity of 2us */
> > -	if (coalesce_usecs % 2 != 0) {
> > -		netdev_info(vsi->netdev, "Invalid value, %s-usecs must
> > be even\n",
> > -			    c_type_str);
> > -		return -EINVAL;
> > -	}
> > -
> >  	if (use_adaptive_coalesce) {
> >  		rc->itr_setting |= ICE_ITR_DYNAMIC;
> >  	} else {
> > -		/* store user facing value how it was set */
> > +		/* save the user set usecs */
> >  		rc->itr_setting = coalesce_usecs;
> > -		/* set to static and convert to value HW understands */
> > -		rc->target_itr =
> > -			ITR_TO_REG(ITR_REG_ALIGN(rc->itr_setting));
> > +		/* device ITR granularity is in 2 usec increments */
> > +		rc->target_itr = ITR_REG_ALIGN(rc->itr_setting);
> >  	}
> >  
> >  	return 0;
> > @@ -3595,6 +3587,30 @@ ice_is_coalesce_param_invalid(struct
> > net_device *netdev,
> >  	return 0;
> >  }
> >  
> > +/**
> > + * ice_print_if_odd_usecs - print message if user tries to set odd
> > [tx|rx]-usecs
> > + * @netdev: netdev used for print
> > + * @itr_setting: previous user setting
> > + * @use_adaptive_coalesce: if adaptive coalesce is enabled or
> > being enabled
> > + * @coalesce_usecs: requested value of [tx|rx]-usecs
> > + * @c_type_str: either "rx" or "tx" to match user set field of
> > [tx|rx]-usecs
> 
> Why `c_type_str`? What does it mean?

It stands for container type string; so whether the container type is
"rx" or "tx".  It is has the same usage in ice_set_rx_coalesce() so we
continued with the convention here.

> > + */
> > +static void
> > +ice_print_if_odd_usecs(struct net_device *netdev, u16 itr_setting,
> > +		       u32 use_adaptive_coalesce, u32 coalesce_usecs,
> > +		       const char *c_type_str)
> > +{
> > +	if (use_adaptive_coalesce)
> > +		return;
> 
> Why not check that before calling the function and not passing the it
> to this
> one.

This is put in the function instead of before calling it to reduce code
duplication.  Adaptive coalesce can be set for Tx and Rx; usecs can
also be set for Tx and RX so putting it in here allows us to use the
same code to do the checks.  Otherwise, we will need to check each
condition for both Tx and Rx before calling this function.

> > +
> > +	itr_setting = ITR_TO_REG(itr_setting);
> > +
> > +	if (itr_setting != coalesce_usecs && (coalesce_usecs % 2))
> > +		netdev_info(netdev, "User set %s-usecs to %d, device
> > only supports even values. Rounding down and attempting to set %s-
> > usecs to %d\n",
> > +			    c_type_str, coalesce_usecs, c_type_str,
> > +			    ITR_REG_ALIGN(coalesce_usecs));
> > +}
> > +
> >  /**
> >   * __ice_set_coalesce - set ITR/INTRL values for the device
> >   * @netdev: pointer to the netdev associated with this query
> > @@ -3615,8 +3631,19 @@ __ice_set_coalesce(struct net_device
> > *netdev, struct ethtool_coalesce *ec,
> >  		return -EINVAL;
> >  
> >  	if (q_num < 0) {
> > +		struct ice_q_vector *q_vector = vsi->q_vectors[0];
> >  		int v_idx;
> >  
> > +		if (q_vector) {
> 
> Why not check for `(coalesce_usecs % 2)` here already?

Explained in previous response.

> > +			ice_print_if_odd_usecs(netdev, q_vector-
> > >rx.itr_setting,
> > +					       ec-
> > >use_adaptive_rx_coalesce,
> > +					       ec->rx_coalesce_usecs,
> > "rx");
> > +
> > +			ice_print_if_odd_usecs(netdev, q_vector-
> > >tx.itr_setting,
> > +					       ec-
> > >use_adaptive_tx_coalesce,
> > +					       ec->tx_coalesce_usecs,
> > "tx");
> > +		}
> > +
> 
> I do not know of such a construct in the rest of the Linux kernel. Is
> there
> a better way to achieve your goal?

I'm not aware of anything else to use, but I'm open to other thoughts
or suggestions if you have any.

Thanks,
Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3277 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200211/9efe9e02/attachment-0001.bin>
