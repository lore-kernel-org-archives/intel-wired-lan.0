From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 30 Jul 2018 20:26:09 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Prevent unsupported
 configurations with XDP
In-Reply-To: <20180730124109.6b67db92@cakuba.netronome.com>
References: <20180730165239.38270-1-anthony.l.nguyen@intel.com>
 <20180730124109.6b67db92@cakuba.netronome.com>
Message-ID: <4C5EDC162D52824D9E7FB1446983F3EECB10C076@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Jakub Kicinski [mailto:jakub.kicinski at netronome.com]
> Sent: Monday, July 30, 2018 12:41 PM
> On Mon, 30 Jul 2018 09:52:39 -0700, Tony Nguyen wrote:
> > These changes address comments by Jakub Kicinski on commit
> > 38b7e7f8ae82 ("ixgbe: Do not allow LRO or MTU change with XDP").
> >
> > Change the MTU check with XDP to allow any supported value and only
> > reject those outside of the range as opposed to rejecting any change
> > when XDP is active. In situations where MTU size is not supported,
> > return -EINVAL instead of -EPERM.
> >
> > Add checks when enabling SRIOV or DCB as those are not supported with
> > XDP.
> >
> > CC: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> Thank you! Buffer size and DCB checks look good AFAIU the ixgbe code :) But..
> 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > index 6f59933cdff7..9264a5f8a5d0 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > @@ -53,6 +53,11 @@ static int __ixgbe_enable_sriov(struct ixgbe_adapter
> *adapter,
> >  	struct ixgbe_hw *hw = &adapter->hw;
> >  	int i;
> >
> > +	if (adapter->xdp_prog) {
> > +		e_warn(probe, "SRIOV is not supported with XDP\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	/* Enable VMDq flag so device will be set in VM mode */
> >  	adapter->flags |= IXGBE_FLAG_SRIOV_ENABLED |
> >  			  IXGBE_FLAG_VMDQ_ENABLED;
> 
> Is there not another path that could enable SR-IOV via ixgbe_fwd_add()?

That's for offloaded macvlans but it does enable SRIOV for it.  I'll do a v2 and add that as well.
