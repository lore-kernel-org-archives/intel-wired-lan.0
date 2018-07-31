From: Basierski, SebastianX <sebastianx.basierski@intel.com>
Date: Tue, 31 Jul 2018 18:11:35 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix driver behaviour after
 issuing VFLR
In-Reply-To: <d68af3a2-00b5-56dc-40cf-b66158de5175@oracle.com>
References: <20180731161600.75051-1-sebastianx.basierski@intel.com>
 <d68af3a2-00b5-56dc-40cf-b66158de5175@oracle.com>
Message-ID: <3A7E81AC661B4646A4CE6F2E09B7B74E05C64477@HASMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Shannon Nelson [mailto:shannon.nelson at oracle.com]
> Sent: Tuesday, July 31, 2018 6:18 PM
> To: Basierski, SebastianX <sebastianx.basierski@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: fix driver behaviour after issuing
> VFLR
> 
> On 7/31/2018 9:16 AM, Sebastian Basierski wrote:
> > Since VFLR doesn't clear VFMBMEM (VF Mailbox Memory) and is not
> > re-enabling queues correctly we should fix this behavior.
> >
> > Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
> > ---
> >   .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 26 +++++++++++++++++++
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  1 +
> >   2 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > index 6f59933cdff7..2bc4fe475f28 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > @@ -688,8 +688,13 @@ static int ixgbe_set_vf_macvlan(struct
> ixgbe_adapter *adapter,
> >   static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter,
> u32 vf)
> >   {
> >   	struct ixgbe_hw *hw = &adapter->hw;
> > +	struct ixgbe_ring_feature *vmdq =
> > +&adapter->ring_feature[RING_F_VMDQ];
> >   	struct vf_data_storage *vfinfo = &adapter->vfinfo[vf];
> > +	u32 q_per_pool = __ALIGN_MASK(1, ~vmdq->mask);
> >   	u8 num_tcs = adapter->hw_tcs;
> > +	u32 reg_val;
> > +	u32 queue;
> > +	u32 word;
> >
> >   	/* remove VLAN filters beloning to this VF */
> >   	ixgbe_clear_vf_vlans(adapter, vf);
> > @@ -726,6 +731,27 @@ static inline void ixgbe_vf_reset_event(struct
> > ixgbe_adapter *adapter, u32 vf)
> >
> >   	/* reset VF api back to unknown */
> >   	adapter->vfinfo[vf].vf_api = ixgbe_mbox_api_10;
> > +
> > +	/* Restart each queue for given VF */
> > +	for (queue = 0; queue < q_per_pool; queue++) {
> > +		unsigned int reg_idx = (vf * q_per_pool) + queue;
> > +
> > +		reg_val = IXGBE_READ_REG(hw,
> IXGBE_PVFTXDCTL(reg_idx));
> > +
> > +		/* Re-enabling only configured queues */
> > +		if (reg_val) {
> > +			reg_val |= IXGBE_TXDCTL_ENABLE;
> > +			IXGBE_WRITE_REG(hw, IXGBE_PVFTXDCTL(reg_idx),
> reg_val);
> > +			reg_val &= ~IXGBE_TXDCTL_ENABLE;
> > +			IXGBE_WRITE_REG(hw, IXGBE_PVFTXDCTL(reg_idx),
> reg_val);
> 
> Why bother creating a new name for an existing register?  Why not use the
> existing define for IXGBE_TXDCTL?
> 

I think PVF prefix used for making a point we are now in VF domain.

 > > +		}
> > +	}
> > +
> > +	/* Clear VF's mailbox memory */
> > +	for (word = 0; word < IXGBE_VFMAILBOX_SIZE; word++)
> > +		IXGBE_WRITE_REG_ARRAY(hw, IXGBE_PFMBMEM(vf), word,
> 0);
> > +
> > +	IXGBE_WRITE_FLUSH(hw);
> >   }
> >
> >   static int ixgbe_set_vf_mac(struct ixgbe_adapter *adapter, diff
> > --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > index 44cfb2021145..41bcbb337e83 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > @@ -2518,6 +2518,7 @@ enum {
> >   /* Translated register #defines */
> >   #define IXGBE_PVFTDH(P)		(0x06010 + (0x40 * (P)))
> >   #define IXGBE_PVFTDT(P)		(0x06018 + (0x40 * (P)))
> > +#define IXGBE_PVFTXDCTL(P)	(0x06028 + (0x40 * (P)))
> >   #define IXGBE_PVFTDWBAL(P)	(0x06038 + (0x40 * (P)))
> >   #define IXGBE_PVFTDWBAH(P)	(0x0603C + (0x40 * (P)))
> 
> For that matter, why do any of these "translated" defines exist when they
> are the same as the un-translated defines?

Same as above.

> 
> sln
> 
> 
> >
> >

Thanks
Sebastian Basierski
SII Engineer
Delivering outsourced services to Intel
e-mail: sebastianx.basierski at intel.com
