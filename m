From: Parikh, Neerav <neerav.parikh@intel.com>
Date: Tue, 8 Dec 2015 18:24:40 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix MDD events generated when
 FCoE+SRIOV are enabled
In-Reply-To: <56670C35.20004@gmail.com>
References: <20151207214354.7597.22257.stgit@neerav-dbg1.jf.intel.com>
 <56670C35.20004@gmail.com>
Message-ID: <739353123C992A4C8800D77E209425909046A8B1@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Tuesday, December 8, 2015 8:58 AM
> To: Parikh, Neerav; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: Fix MDD events generated when
> FCoE+SRIOV are enabled
> 
> On 12/07/2015 01:43 PM, Neerav Parikh wrote:
> > When FCoE is enabled with SR-IOV on the X550 NIC the hardware
> > generates MDD events.
> >
> > This patch fixes these by setting the expected values in the
> > Tx context descriptors for FCoE/FIP frames and adding a flush
> > after writing the RDLEN register.
> >
> > Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
> > ---
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |    5 ++++-
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   18 ++++++++++++++++++
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    1 +
> >   3 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> > index 5f98870..78ffef4 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> > @@ -517,6 +517,7 @@ int ixgbe_fso(struct ixgbe_ring *tx_ring,
> >   	u32 vlan_macip_lens;
> >   	u32 fcoe_sof_eof = 0;
> >   	u32 mss_l4len_idx;
> > +	u32 type_tucmd = IXGBE_ADVTXT_TUCMD_FCOE;
> >   	u8 sof, eof;
> >
> >   	if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type != SKB_GSO_FCOE)) {
> > @@ -593,6 +594,8 @@ int ixgbe_fso(struct ixgbe_ring *tx_ring,
> >   					       skb_shinfo(skb)->gso_size);
> >   		first->bytecount += (first->gso_segs - 1) * *hdr_len;
> >   		first->tx_flags |= IXGBE_TX_FLAGS_TSO;
> > +		/* Hardware expects L4T to be RSV for FCoE TSO */
> > +		type_tucmd |= IXGBE_ADVTXD_TUCMD_L4T_RSV;
> >   	}
> >
> >   	/* set flag indicating FCOE to ixgbe_tx_map call */
> > @@ -610,7 +613,7 @@ int ixgbe_fso(struct ixgbe_ring *tx_ring,
> >
> >   	/* write context desc */
> >   	ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, fcoe_sof_eof,
> > -			  IXGBE_ADVTXT_TUCMD_FCOE, mss_l4len_idx);
> > +			  type_tucmd, mss_l4len_idx);
> >
> >   	return 0;
> >   }
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > index ebd4522..c31ed4c 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > @@ -3619,6 +3619,9 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter
> *adapter,
> >   	IXGBE_WRITE_REG(hw, IXGBE_RDBAH(reg_idx), (rdba >> 32));
> >   	IXGBE_WRITE_REG(hw, IXGBE_RDLEN(reg_idx),
> >   			ring->count * sizeof(union ixgbe_adv_rx_desc));
> > +	/* Force flushing of IXGBE_RDLEN to prevent MDD */
> > +	IXGBE_WRITE_FLUSH(hw);
> > +
> >   	IXGBE_WRITE_REG(hw, IXGBE_RDH(reg_idx), 0);
> >   	IXGBE_WRITE_REG(hw, IXGBE_RDT(reg_idx), 0);
> >   	ring->tail = adapter->io_addr + IXGBE_RDT(reg_idx);
> > @@ -7641,6 +7644,21 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff
> *skb,
> >   			goto out_drop;
> >
> >   		goto xmit_fcoe;
> > +	} else if (protocol ==  htons(ETH_P_FIP)) {
> > +		/* A zero as offset will result in HW generating malicious event
> > +		 * when trying to Tx a FIP frame. So, set a valid header length
> > +		 * to prevent such an event.
> > +		 */
> > +		if (!skb_network_offset(skb)) {
> > +			if (tx_flags & (IXGBE_TX_FLAGS_HW_VLAN |
> > +			    IXGBE_TX_FLAGS_SW_VLAN))
> > +				skb_set_network_header(skb,
> > +						       sizeof(struct ethhdr) +
> > +						       sizeof(struct vlan_hdr));
> > +			else
> > +				skb_set_network_header(skb,
> > +						       sizeof(struct ethhdr));
> > +		}
> >   	}
> >
> 
> I'm pretty sure this code is incorrect.  The offset would only require
> the vlan_hdr if to be included if the hardware was not offloading the
> VLAN tag insertion.
> 
> Instead of setting the network header in the driver why not locate where
> the FIP frame is being generated and set it there in the first place?
> That way you can save anyone else who might be working with FCoE the
> trouble of having to correct the layout of the frames?
> 
> - Alex
Thanks for reviewing this Alex; the only reason I added it in the driver was because
there may be multiple sources for the FIP frames (user space or FCoE stack) and
MDD from the ixgbe driver would show as some kind of error from the ixgbe driver
v/s the source that generated or created the packet.
I'll remove this portion from the patch for now and see if I can address the issue in the
FCoE stack where the FIP frames are generated as per your suggestion.


