From: Matt Corallo <linux-wired-list@bluematt.me>
Date: Sun, 31 Jan 2021 18:17:11 -0500
Subject: [Intel-wired-lan] [PATCH net] igb: Enable RSS for Intel I211
 Ethernet Controller
In-Reply-To: <20201221222502.1706-1-nick.lowe@gmail.com>
References: <20201221222502.1706-1-nick.lowe@gmail.com>
Message-ID: <379d4ef3-02e5-f08a-1b04-21848e11a365@bluematt.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Given this fixes a major (albeit ancient) performance regression, is it not a candidate for backport? It landed on 
Tony's dev-queue branch with a Fixes tag but no stable CC.

Thanks,
Matt

On 12/21/20 5:25 PM, Nick Lowe wrote:
> The Intel I211 Ethernet Controller supports 2 Receive Side Scaling (RSS) queues.
> It should not be excluded from having this feature enabled.
> 
> Via commit c883de9fd787b6f49bf825f3de3601aeb78a7114
> E1000_MRQC_ENABLE_RSS_4Q was renamed to E1000_MRQC_ENABLE_RSS_MQ to
> indicate that this is a generic bit flag to enable queues and not
> a flag that is specific to devices that support 4 queues
> 
> The bit flag enables 2, 4 or 8 queues appropriately depending on the part.
> 
> Tested with a multicore CPU and frames were then distributed as expected.
> 
> This issue appears to have been introduced because of confusion caused
> by the prior name.
> 
> Signed-off-by: Nick Lowe <nick.lowe@gmail.com>
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 03f78fdb0dcd..87ac1d3e25cb 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4482,8 +4482,7 @@ static void igb_setup_mrqc(struct igb_adapter *adapter)
>   		else
>   			mrqc |= E1000_MRQC_ENABLE_VMDQ;
>   	} else {
> -		if (hw->mac.type != e1000_i211)
> -			mrqc |= E1000_MRQC_ENABLE_RSS_MQ;
> +		mrqc |= E1000_MRQC_ENABLE_RSS_MQ;
>   	}
>   	igb_vmm_control(adapter);
>   
> 
