From: Venkataramanan, Anirudh <anirudh.venkataramanan@intel.com>
Date: Thu, 18 Oct 2018 21:05:31 +0000
Subject: [Intel-wired-lan] [PATCH 5/7] ice: Introduce
 ice_dev_onetime_setup
In-Reply-To: <18a2f2e3-1d48-cc76-359e-838226a172ce@oracle.com>
References: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
 <20181018153709.32664-6-anirudh.venkataramanan@intel.com>
 <18a2f2e3-1d48-cc76-359e-838226a172ce@oracle.com>
Message-ID: <cbcab35f87eae8f3eedbd04695a0684085aab9d6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2018-10-18 at 09:06 -0700, Shannon Nelson wrote:
> On 10/18/2018 8:37 AM, Anirudh Venkataramanan wrote:
> > ice_dev_onetime_setup contains a couple of driver workarounds for
> > current
> > firmware limitations. These workarounds are expected to go away
> > once
> > these limitations are fixed in the firmware.
> 
> Can you add a check for firmware version or feature to see if this
> is 
> needed before using it?
> 
> sln

Hi Shannon,

We discussed this internally a few weeks back and the conclusion was
that right now there's no reliable way to apply these workarounds
conditionally.

On a FW release that has these issues addressed, these workarounds
while unncessary, won't break anything. So for now, IMHO, it's fine the
way it is.

Thanks,
Ani

> 
> 
> > 
> > Signed-off-by: Anirudh Venkataramanan <
> > anirudh.venkataramanan at intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_common.c     | 19
> > +++++++++++++++++++
> >   drivers/net/ethernet/intel/ice/ice_common.h     |  3 +++
> >   drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  2 ++
> >   drivers/net/ethernet/intel/ice/ice_lib.c        |  1 +
> >   4 files changed, 25 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
> > b/drivers/net/ethernet/intel/ice/ice_common.c
> > index 78df54b25bf1..5a91a9087d1e 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_common.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> > @@ -42,6 +42,23 @@ static enum ice_status ice_set_mac_type(struct
> > ice_hw *hw)
> >   	return 0;
> >   }
> >   
> > +/**
> > + * ice_dev_onetime_setup - Temporary HW/FW workarounds
> > + * @hw: pointer to the HW structure
> > + *
> > + * This function provides temporary workarounds for certain issues
> > + * that are expected to be fixed in the HW/FW.
> > + */
> > +void ice_dev_onetime_setup(struct ice_hw *hw)
> > +{
> > +	/* configure Rx - set non pxe mode */
> > +	wr32(hw, GLLAN_RCTL_0, 0x1);
> > +
> > +#define MBX_PF_VT_PFALLOC	0x00231E80
> > +	/* set VFs per PF */
> > +	wr32(hw, MBX_PF_VT_PFALLOC, rd32(hw, PF_VT_PFALLOC_HIF));
> > +}
> > +
> >   /**
> >    * ice_clear_pf_cfg - Clear PF configuration
> >    * @hw: pointer to the hardware structure
> > @@ -740,6 +757,8 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
> >   	if (status)
> >   		goto err_unroll_sched;
> >   
> > +	ice_dev_onetime_setup(hw);
> > +
> >   	/* Get MAC information */
> >   	/* A single port can report up to two (LAN and WoL) addresses
> > */
> >   	mac_buf = devm_kcalloc(ice_hw_to_dev(hw), 2,
> > diff --git a/drivers/net/ethernet/intel/ice/ice_common.h
> > b/drivers/net/ethernet/intel/ice/ice_common.h
> > index 1900681289a4..876347e32b6f 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_common.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_common.h
> > @@ -34,6 +34,9 @@ ice_sq_send_cmd(struct ice_hw *hw, struct
> > ice_ctl_q_info *cq,
> >   		struct ice_sq_cd *cd);
> >   void ice_clear_pxe_mode(struct ice_hw *hw);
> >   enum ice_status ice_get_caps(struct ice_hw *hw);
> > +
> > +void ice_dev_onetime_setup(struct ice_hw *hw);
> > +
> >   enum ice_status
> >   ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx
> > *rlan_ctx,
> >   		  u32 rxq_index);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> > b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> > index a6679a9bfd3a..228afcad6fc3 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> > @@ -157,6 +157,7 @@
> >   #define VPINT_ALLOC_LAST_S			12
> >   #define VPINT_ALLOC_LAST_M			ICE_M(0x7FF,
> > 12)
> >   #define VPINT_ALLOC_VALID_M			BIT(31)
> > +#define GLLAN_RCTL_0				0x002941F8
> >   #define QRX_CONTEXT(_i, _QRX)			(0x00280000 +
> > ((_i) * 8192 + (_QRX) * 4))
> >   #define QRX_CTRL(_QRX)				(0x00120000 +
> > ((_QRX) * 4))
> >   #define QRX_CTRL_MAX_INDEX			2047
> > @@ -320,6 +321,7 @@
> >   #define GLV_UPRCL(_i)				(0x003B2000 +
> > ((_i) * 8))
> >   #define GLV_UPTCH(_i)				(0x0030A004 +
> > ((_i) * 8))
> >   #define GLV_UPTCL(_i)				(0x0030A000 +
> > ((_i) * 8))
> > +#define PF_VT_PFALLOC_HIF			0x0009DD80
> >   #define VSIQF_HKEY_MAX_INDEX			12
> >   #define VSIQF_HLUT_MAX_INDEX			15
> >   #define VFINT_DYN_CTLN(_i)			(0x00003800 +
> > ((_i) * 4))
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> > b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index e750702bcdce..5bacad01f0c9 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -2529,6 +2529,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi)
> >   	vsi->hw_base_vector = 0;
> >   	ice_vsi_clear_rings(vsi);
> >   	ice_vsi_free_arrays(vsi, false);
> > +	ice_dev_onetime_setup(&vsi->back->hw);
> >   	ice_vsi_set_num_qs(vsi);
> >   
> >   	/* Initialize VSI struct elements and create VSI in FW */
> > 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3302 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181018/2676020d/attachment-0001.bin>
