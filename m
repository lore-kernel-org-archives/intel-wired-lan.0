From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Wed, 22 Apr 2015 07:39:17 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: i219 execute unit hang fix on
 every reset or power state transition
In-Reply-To: <1429665301-10596-1-git-send-email-yanirx.lubetkin@intel.com>
References: <1429665301-10596-1-git-send-email-yanirx.lubetkin@intel.com>
Message-ID: <5537B295.3060804@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/21/2015 06:15 PM, Yanir Lubetkin wrote:
> after testing various cases, the conclusion is that the fix MUST be executed BEFORE
> any event that the HW is reset or transition to D3. to fix that I moved the execution
> to the relevant places but per Alexander Duyck's review, ensure now that the DMA is
> valid and was not freed before manipulating the ring.
>
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 76b1a90..3f561f3 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -4043,6 +4043,8 @@ void e1000e_reset(struct e1000_adapter *adapter)
>   		}
>   	}
>
> +	if (hw->mac.type == e1000_pch_spt)
> +		e1000_flush_desc_rings(adapter);
>   	/* Allow time for pending master requests to run */
>   	mac->ops.reset_hw(hw);
>
> @@ -4215,10 +4217,6 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
>   	spin_unlock(&adapter->stats64_lock);
>
>   	e1000e_flush_descriptors(adapter);
> -	if (hw->mac.type == e1000_pch_spt)
> -		e1000_flush_desc_rings(adapter);
> -	e1000_clean_tx_ring(adapter->tx_ring);
> -	e1000_clean_rx_ring(adapter->rx_ring);
>
>   	adapter->link_speed = 0;
>   	adapter->link_duplex = 0;
> @@ -4229,8 +4227,14 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
>   	    e1000_lv_jumbo_workaround_ich8lan(hw, false))
>   		e_dbg("failed to disable jumbo frame workaround mode\n");
>
> -	if (reset && !pci_channel_offline(adapter->pdev))
> -		e1000e_reset(adapter);
> +        if (!pci_channel_offline(adapter->pdev)) {
> +                if(reset)
> +                        e1000e_reset(adapter);
> +                else if (hw->mac.type == e1000_pch_spt)
> +                        e1000_flush_desc_rings(adapter);
> +        }
> +	e1000_clean_tx_ring(adapter->tx_ring);
> +	e1000_clean_rx_ring(adapter->rx_ring);
>   }
>
>   void e1000e_reinit_locked(struct e1000_adapter *adapter)
>

I'm really not a fan of this as it really seems to confuse things.  Do 
you know if you need the full workaround or only part of it?  For 
example if the descriptor ring is empty flushing the descriptor rings 
shouldn't be necessary, so I suspect you probably only need to move the 
bits where you were setting E1000_FEXTNVM11_DISABLE_MULR_FIX into the 
e1000_reset_hw_ich8lan call itself and then you could probably just 
leave the rest of the workaround as is.

- Alex
