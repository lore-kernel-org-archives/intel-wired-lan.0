From: Benjamin Poirier <benjamin.poirier@gmail.com>
Date: Thu, 8 Feb 2018 17:05:57 +0900
Subject: [Intel-wired-lan] [PATCH net-queue 1/3] Partial revert "e1000e:
 Avoid receiver overrun interrupt bursts"
In-Reply-To: <20180208064714.6042-1-bpoirier@suse.com>
References: <20180208064714.6042-1-bpoirier@suse.com>
Message-ID: <20180208080557.yqxdgvr4xef3zszq@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I forgot to mark it as such but this is v2 of the series originally
submitted in this thread:
https://lkml.org/lkml/2018/1/26/93

Changes since v1:
* series rebased to apply over "e1000e: Remove Other from EIAC."
  http://patchwork.ozlabs.org/patch/867833/
  This essentially removes patch 3/3 from the original series.
* dropped [PATCH 2/3] Revert "e1000e: Separate signaling for link
  check/link up". After Alex's feedback, I think that problem needs to
  be addressed differently and I will submit a separate patch for it.
* patch 1 was split into three parts. Instead of manually clearing OTHER
  via a write to icr as in v1, in v2 we make sure that INT_ASSERTED is
  always set via bits for all events related to the Other interrupt in
  IMS.

Benjamin Poirier (3):
  Partial revert "e1000e: Avoid receiver overrun interrupt bursts"
  e1000e: Fix queue interrupt re-raising in Other interrupt.
  e1000e: Avoid missed interrupts following ICR read.

 drivers/net/ethernet/intel/e1000e/defines.h | 21 ++++++++++++++++++-
 drivers/net/ethernet/intel/e1000e/netdev.c  | 32 +++++++++--------------------
 2 files changed, 30 insertions(+), 23 deletions(-)

On 2018/02/08 15:47, Benjamin Poirier wrote:
> This partially reverts commit 4aea7a5c5e940c1723add439f4088844cd26196d.
> 
> We keep the fix for the first part of the problem (1) described in the log
> of that commit, that is to read ICR in the other interrupt handler. We
> remove the fix for the second part of the problem (2), Other interrupt
> throttling.
> 
> Bursts of "Other" interrupts may once again occur during rxo (receive
> overflow) traffic conditions. This is deemed acceptable in the interest of
> avoiding unforeseen fallout from changes that are not strictly necessary.
> As discussed, the e1000e driver should be in "maintenance mode".
> 
> Link: https://www.spinics.net/lists/netdev/msg480675.html
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 153ad406c65e..3b36efa6228d 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1915,21 +1915,10 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
>  	struct e1000_adapter *adapter = netdev_priv(netdev);
>  	struct e1000_hw *hw = &adapter->hw;
>  	u32 icr;
> -	bool enable = true;
>  
>  	icr = er32(ICR);
>  	ew32(ICR, E1000_ICR_OTHER);
>  
> -	if (icr & E1000_ICR_RXO) {
> -		ew32(ICR, E1000_ICR_RXO);
> -		enable = false;
> -		/* napi poll will re-enable Other, make sure it runs */
> -		if (napi_schedule_prep(&adapter->napi)) {
> -			adapter->total_rx_bytes = 0;
> -			adapter->total_rx_packets = 0;
> -			__napi_schedule(&adapter->napi);
> -		}
> -	}
>  	if (icr & E1000_ICR_LSC) {
>  		ew32(ICR, E1000_ICR_LSC);
>  		hw->mac.get_link_status = true;
> @@ -1938,7 +1927,7 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
>  			mod_timer(&adapter->watchdog_timer, jiffies + 1);
>  	}
>  
> -	if (enable && !test_bit(__E1000_DOWN, &adapter->state))
> +	if (!test_bit(__E1000_DOWN, &adapter->state))
>  		ew32(IMS, E1000_IMS_OTHER);
>  
>  	return IRQ_HANDLED;
> @@ -2708,8 +2697,7 @@ static int e1000e_poll(struct napi_struct *napi, int weight)
>  		napi_complete_done(napi, work_done);
>  		if (!test_bit(__E1000_DOWN, &adapter->state)) {
>  			if (adapter->msix_entries)
> -				ew32(IMS, adapter->rx_ring->ims_val |
> -				     E1000_IMS_OTHER);
> +				ew32(IMS, adapter->rx_ring->ims_val);
>  			else
>  				e1000_irq_enable(adapter);
>  		}
> -- 
> 2.16.1
> 
