From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 20 Feb 2018 17:55:06 -0800
Subject: [Intel-wired-lan] [PATCH net-queue] e1000e: Fix check_for_link
 return value with autoneg off.
In-Reply-To: <20180220061200.17708-1-bpoirier@suse.com>
References: <20180220061200.17708-1-bpoirier@suse.com>
Message-ID: <1908e13b-3706-08d7-9ebb-5774b7d7cfb4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/19/2018 22:12, Benjamin Poirier wrote:
> When autoneg is off, the .check_for_link callback functions clear the
> get_link_status flag and systematically return a "pseudo-error". This means
> that the link is not detected as up until the next execution of the
> e1000_watchdog_task() 2 seconds later.
> 
> Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
>   drivers/net/ethernet/intel/e1000e/mac.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 31277d3bb7dc..ff308b05d68c 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1602,7 +1602,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>   	 * we have already determined whether we have link or not.
>   	 */
>   	if (!mac->autoneg)
> -		return -E1000_ERR_CONFIG;
> +		return 1;
>   
>   	/* Auto-Neg is enabled.  Auto Speed Detection takes care
>   	 * of MAC speed/duplex configuration.  So we only need to
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index f457c5703d0c..db735644b312 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -450,7 +450,7 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
>   	 * we have already determined whether we have link or not.
>   	 */
>   	if (!mac->autoneg)
> -		return -E1000_ERR_CONFIG;
> +		return 1;
>   
>   	/* Auto-Neg is enabled.  Auto Speed Detection takes care
>   	 * of MAC speed/duplex configuration.  So we only need to
> 
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
