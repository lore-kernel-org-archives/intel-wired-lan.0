From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 28 Jun 2018 10:07:31 +0300
Subject: [Intel-wired-lan] [RFC PATCH] igc: igc_reset() can be static
In-Reply-To: <20180624123359.GA130268@lkp-hsx03>
References: <20180624084503.10065-1-sasha.neftin@intel.com>
 <20180624123359.GA130268@lkp-hsx03>
Message-ID: <be2a2283-b7f6-0e4c-e929-f1aa83a5cdfe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/24/2018 15:34, kbuild test robot wrote:
> 
> Fixes: e1df6cb3a70b ("igc: Add netdev")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> ---
>   igc_main.c |   14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 520f49b..32669855 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -34,7 +34,7 @@ static void igc_configure(struct igc_adapter *adapter);
>   static void igc_power_down_link(struct igc_adapter *adapter);
>   static void igc_set_default_mac_filter(struct igc_adapter *adapter);
>   
> -void igc_reset(struct igc_adapter *adapter)
> +static void igc_reset(struct igc_adapter *adapter)
>   {
>   	if (!netif_running(adapter->netdev))
>   		igc_power_down_link(adapter);
> @@ -44,7 +44,7 @@ void igc_reset(struct igc_adapter *adapter)
>    *  igc_power_up_link - Power up the phy/serdes link
>    *  @adapter: address of board private structure
>    **/
> -void igc_power_up_link(struct igc_adapter *adapter)
> +static void igc_power_up_link(struct igc_adapter *adapter)
>   {
>   }
>   
> @@ -144,7 +144,7 @@ static int igc_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
>    *  igc_up - Open the interface and prepare it to handle traffic
>    *  @adapter: board private structure
>    **/
> -int igc_up(struct igc_adapter *adapter)
> +static int igc_up(struct igc_adapter *adapter)
>   {
>   	int i = 0;
>   
> @@ -163,7 +163,7 @@ int igc_up(struct igc_adapter *adapter)
>    *  igc_down - Close the interface
>    *  @adapter: board private structure
>    **/
> -void igc_down(struct igc_adapter *adapter)
> +static void igc_down(struct igc_adapter *adapter)
>   {
>   	struct net_device *netdev = adapter->netdev;
>   	int i = 0;
> @@ -227,7 +227,7 @@ static int igc_change_mtu(struct net_device *netdev, int new_mtu)
>    *  igc_update_stats - Update the board statistics counters
>    *  @adapter: board private structure
>    **/
> -void igc_update_stats(struct igc_adapter *adapter)
> +static void igc_update_stats(struct igc_adapter *adapter)
>   {
>   }
>   
> @@ -347,7 +347,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
>   	return E1000_SUCCESS;
>   }
>   
> -int igc_open(struct net_device *netdev)
> +static int igc_open(struct net_device *netdev)
>   {
>   	return __igc_open(netdev, false);
>   }
> @@ -376,7 +376,7 @@ static int __igc_close(struct net_device *netdev, bool suspending)
>   	return 0;
>   }
>   
> -int igc_close(struct net_device *netdev)
> +static int igc_close(struct net_device *netdev)
>   {
>   	if (netif_device_present(netdev) || netdev->dismantle)
>   		return __igc_close(netdev, false);
> 
good. will be applied to v4.
Thanks,
Sasha
