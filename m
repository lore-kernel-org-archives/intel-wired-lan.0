From: Lubetkin, YanirX <yanirx.lubetkin@intel.com>
Date: Wed, 22 Apr 2015 14:56:39 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: i219 execute unit hang fix on
 every reset or power state transition
In-Reply-To: <5537B295.3060804@redhat.com>
References: <1429665301-10596-1-git-send-email-yanirx.lubetkin@intel.com>
 <5537B295.3060804@redhat.com>
Message-ID: <4D1FB504F643AC4BA12C9F34A1763FA419CA10F1@HASMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.h.duyck at redhat.com]
> Sent: Wednesday, April 22, 2015 17:39
> To: Lubetkin, YanirX; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH] e1000e: i219 execute unit hang fix on
> every reset or power state transition
> 
> On 04/21/2015 06:15 PM, Yanir Lubetkin wrote:
> > after testing various cases, the conclusion is that the fix MUST be
> > executed BEFORE any event that the HW is reset or transition to D3. to
> > fix that I moved the execution to the relevant places but per
> > Alexander Duyck's review, ensure now that the DMA is valid and was not
> freed before manipulating the ring.
> >
> > Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> > ---
> >   drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++++++++++------
> >   1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> > b/drivers/net/ethernet/intel/e1000e/netdev.c
> > index 76b1a90..3f561f3 100644
> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > @@ -4043,6 +4043,8 @@ void e1000e_reset(struct e1000_adapter
> *adapter)
> >   		}
> >   	}
> >
> > +	if (hw->mac.type == e1000_pch_spt)
> > +		e1000_flush_desc_rings(adapter);
> >   	/* Allow time for pending master requests to run */
> >   	mac->ops.reset_hw(hw);
> >
> > @@ -4215,10 +4217,6 @@ void e1000e_down(struct e1000_adapter
> *adapter, bool reset)
> >   	spin_unlock(&adapter->stats64_lock);
> >
> >   	e1000e_flush_descriptors(adapter);
> > -	if (hw->mac.type == e1000_pch_spt)
> > -		e1000_flush_desc_rings(adapter);
> > -	e1000_clean_tx_ring(adapter->tx_ring);
> > -	e1000_clean_rx_ring(adapter->rx_ring);
> >
> >   	adapter->link_speed = 0;
> >   	adapter->link_duplex = 0;
> > @@ -4229,8 +4227,14 @@ void e1000e_down(struct e1000_adapter
> *adapter, bool reset)
> >   	    e1000_lv_jumbo_workaround_ich8lan(hw, false))
> >   		e_dbg("failed to disable jumbo frame workaround
> mode\n");
> >
> > -	if (reset && !pci_channel_offline(adapter->pdev))
> > -		e1000e_reset(adapter);
> > +        if (!pci_channel_offline(adapter->pdev)) {
> > +                if(reset)
> > +                        e1000e_reset(adapter);
> > +                else if (hw->mac.type == e1000_pch_spt)
> > +                        e1000_flush_desc_rings(adapter);
> > +        }
> > +	e1000_clean_tx_ring(adapter->tx_ring);
> > +	e1000_clean_rx_ring(adapter->rx_ring);
> >   }
> >
> >   void e1000e_reinit_locked(struct e1000_adapter *adapter)
> >
> 
> I'm really not a fan of this as it really seems to confuse things.  Do you know if
> you need the full workaround or only part of it?  For example if the
> descriptor ring is empty flushing the descriptor rings shouldn't be necessary,
> so I suspect you probably only need to move the bits where you were setting
> E1000_FEXTNVM11_DISABLE_MULR_FIX into the e1000_reset_hw_ich8lan
> call itself and then you could probably just leave the rest of the workaround
> as is.

The logic is:

If the bit is SET and TDLEN > 0
	Clear E1000_FEXTNVM11_DISABLE_MULR_FIX
	Execute TX ring flush
If the bit is still set
	Execute the RX flush

This logic should be executed before any attempt to reset the hardware (unless resetting the bus), and before any state transition out of D0.

the E1000_FEXTNVM11_DISABLE_MULR_FIX  bit will return SET from reset. It is set when reloading the NVM.


> 
> - Alex
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

