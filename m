From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 15 Nov 2017 08:48:25 -0800
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: Alert the user that
 C-states will be disabled by enabling jumbo frames
In-Reply-To: <20171114235133.14755-1-mattst88@gmail.com>
References: <20171107221332.28283-2-mattst88@gmail.com>
 <20171114235133.14755-1-mattst88@gmail.com>
Message-ID: <b8ed0ac5-2dc7-7216-627a-9228eac120bc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/14/2017 3:51 PM, Matt Turner wrote:
> From: Matt Turner <matt.turner@intel.com>
> 
> I personally spent a long time trying to decypher why my CPU would not
> reach deeper C-states. Let's just tell the next user what's going on.
> 
> Signed-off-by: Matt Turner <matt.turner@intel.com>
> ---
> v2: Per Shannon, put string on one line for easier grepping

Acked-by: Shannon Nelson <shannon.nelson@oracle.com>

> 
>   drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 286d0277284e..31577dad22cb 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3288,6 +3288,8 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
>   			ew32(RXDCTL(0), rxdctl | 0x3 | BIT(8));
>   		}
>   
> +		dev_info(&adapter->pdev->dev,
> +			 "Some CPU C-states have been disabled in order to enable jumbo frames\n");
>   		pm_qos_update_request(&adapter->pm_qos_req, lat);
>   	} else {
>   		pm_qos_update_request(&adapter->pm_qos_req,
> 
