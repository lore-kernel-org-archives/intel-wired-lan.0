From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Mon, 25 Feb 2019 20:26:13 +0200
Subject: [Intel-wired-lan] [PATCH net-next 3/4] e1000e: Fix
 -Wformat-truncation warnings
In-Reply-To: <20190222040929.16657-4-f.fainelli@gmail.com>
References: <20190222040929.16657-1-f.fainelli@gmail.com>
 <20190222040929.16657-4-f.fainelli@gmail.com>
Message-ID: <69782768-4bba-6442-a1e4-3b019847e53b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 22/02/2019 6:09, Florian Fainelli wrote:
> Provide precision hints to snprintf() since we know the destination
> buffer size of the RX/TX ring names are IFNAMSIZ + 5 - 1. This fixes the
> following warnings:
> 
> drivers/net/ethernet/intel/e1000e/netdev.c: In function
> 'e1000_request_msix':
> drivers/net/ethernet/intel/e1000e/netdev.c:2109:13: warning: 'snprintf'
> output may be truncated before the last format character
> [-Wformat-truncation=]
>       "%s-rx-0", netdev->name);
>               ^
> drivers/net/ethernet/intel/e1000e/netdev.c:2107:3: note: 'snprintf'
> output between 6 and 21 bytes into a destination of size 20
>     snprintf(adapter->rx_ring->name,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       sizeof(adapter->rx_ring->name) - 1,
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       "%s-rx-0", netdev->name);
>       ~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/e1000e/netdev.c:2125:13: warning: 'snprintf'
> output may be truncated before the last format character
> [-Wformat-truncation=]
>       "%s-tx-0", netdev->name);
>               ^
> drivers/net/ethernet/intel/e1000e/netdev.c:2123:3: note: 'snprintf'
> output between 6 and 21 bytes into a destination of size 20
>     snprintf(adapter->tx_ring->name,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       sizeof(adapter->tx_ring->name) - 1,
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       "%s-tx-0", netdev->name);
>       ~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 736fa51878f8..7acc61e4f645 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -2106,7 +2106,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
>   	if (strlen(netdev->name) < (IFNAMSIZ - 5))
>   		snprintf(adapter->rx_ring->name,
>   			 sizeof(adapter->rx_ring->name) - 1,
> -			 "%s-rx-0", netdev->name);
> +			 "%.14s-rx-0", netdev->name);
>   	else
>   		memcpy(adapter->rx_ring->name, netdev->name, IFNAMSIZ);
>   	err = request_irq(adapter->msix_entries[vector].vector,
> @@ -2122,7 +2122,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
>   	if (strlen(netdev->name) < (IFNAMSIZ - 5))
>   		snprintf(adapter->tx_ring->name,
>   			 sizeof(adapter->tx_ring->name) - 1,
> -			 "%s-tx-0", netdev->name);
> +			 "%.14s-tx-0", netdev->name);
>   	else
>   		memcpy(adapter->tx_ring->name, netdev->name, IFNAMSIZ);
>   	err = request_irq(adapter->msix_entries[vector].vector,
> 
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
