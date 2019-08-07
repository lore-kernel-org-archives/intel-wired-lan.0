From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 7 Aug 2019 11:16:05 +0300
Subject: [Intel-wired-lan] [PATCH v5] e1000e: PCIm function state support
In-Reply-To: <20190807073611.21733-1-vitaly.lifshits@intel.com>
References: <20190807073611.21733-1-vitaly.lifshits@intel.com>
Message-ID: <75aae517-972f-0636-6d53-52d12400a1a9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/7/2019 10:36, Vitaly Lifshits wrote:
> Due to commit: 5d8682588605 ("[misc] mei: me: allow runtime pm for
> platform with D0i3"), when the cable is disconnect and reconnected,
> the NIC can enter a DMoff state.  The DMoff state will cause incorrect
> link indication and duplex setting mismatch.
> 
> To resolve this, we need to check the PCIm function state and perform
> a PHY reset after exiting the DMoff state in our watchdog service task.
> 
> Fixes: 5d8682588605 ("[misc] mei: me: allow runtime pm for platform with D0i3")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1689436
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> ---
> 
> V2: Fix typos in commit message
> V3: Fix minor typo
> V4: Address community comments
> V5: Address community comments
> ---
>   drivers/net/ethernet/intel/e1000e/defines.h |  4 ++++
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 20 +++++++++++++++++++-
>   2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
> index fd550dee4982..11452eaac233 100644
> --- a/drivers/net/ethernet/intel/e1000e/defines.h
> +++ b/drivers/net/ethernet/intel/e1000e/defines.h
> @@ -222,6 +222,10 @@
>   #define E1000_STATUS_PHYRA      0x00000400      /* PHY Reset Asserted */
>   #define E1000_STATUS_GIO_MASTER_ENABLE	0x00080000	/* Master Req status */
>   
> +/* PCIm function state */
> +#define E1000_STATUS_PCIM_STATE	0x40000000
> +#define PCIM_DMOFF_EXIT_TIMEOUT	100
> +
>   #define HALF_DUPLEX 1
>   #define FULL_DUPLEX 2
>   
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index b5fed6177ad6..639266485c15 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5162,7 +5162,7 @@ static void e1000_watchdog_task(struct work_struct *work)
>   	struct e1000_phy_info *phy = &adapter->hw.phy;
>   	struct e1000_ring *tx_ring = adapter->tx_ring;
>   	struct e1000_hw *hw = &adapter->hw;
> -	u32 link, tctl;
> +	u32 link, tctl, pcim_state, tries = 0;
>   
>   	if (test_bit(__E1000_DOWN, &adapter->state))
>   		return;
> @@ -5187,6 +5187,24 @@ static void e1000_watchdog_task(struct work_struct *work)
>   			/* Cancel scheduled suspend requests. */
>   			pm_runtime_resume(netdev->dev.parent);
>   
> +			/* Check if MAC is in DMoff state */
> +			pcim_state = er32(STATUS);
> +			while (pcim_state & E1000_STATUS_PCIM_STATE) {
> +				if (tries++ == PCIM_DMOFF_EXIT_TIMEOUT) {
> +					e_dbg("Error in exiting dmoff\n");
> +					e_err("PCIm DMoff timeout expired\n");
> +					break;
> +				}
> +				usleep_range(10000, 20000);
> +				pcim_state = er32(STATUS);
> +
> +				/* If MAC entered DMoff state, PHY reset is
> +				 * needed after exiting it
> +				 */
> +				if (!(pcim_state & E1000_STATUS_PCIM_STATE))
> +					e1000_phy_hw_reset(&adapter->hw);
> +			}
> +
>   			/* update snapshot of PHY registers on LSC */
>   			e1000_phy_read_status(adapter);
>   			mac->ops.get_link_up_info(&adapter->hw,
> 
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
