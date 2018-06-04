From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 4 Jun 2018 10:34:51 -0700
Subject: [Intel-wired-lan] [net-queue PATCH] ixgbe: Move ipsec init
 function to before reset call
In-Reply-To: <20180604162312.79628.37984.stgit@ahduyck-green-test.jf.intel.com>
References: <20180604162312.79628.37984.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <4b8f422b-b694-6729-709d-647d44148e7c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/4/2018 9:24 AM, Alexander Duyck wrote:
> This patch moves the ipsec init function in ixgbe_sw_init. This way it is a
> bit more consistent with the placement of similar initialization functions
> and is placed before the reset_hw call which should allow us to clean up
> any link issues that may be introduced by the fact that we force the link
> up if somehow the device had ipsec still enabled before the driver was
> loaded.
> 
> Fixes: 49a94d74d948 ("ixgbe: add ipsec engine start and stop routines")
> Reported-by: Andre Tomt <andre@tomt.net>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---

NAK - this won't work for the simple reason that the netdev feature 
flags that ixgbe_init_ipsec_offload() sets will get bashed later when 
probe() starts setting netdev feature flags.

The call to stop the engine in the init is probably unnecessary, I 
really put it there to be sure that no crap was left lying around from 
before the driver was started.  This can probably be removed to address 
Alex's timing worries.

We really need a way to check the SEC_EN or ENCRYPTION_EN pins to see if 
the chip has it supported.  The alternative is to do a quick check to 
see if we can write to SECTXCTRL.SECTX_DIS and SECRXCTRL.SECRX_DIS to 
clear those bits.  Since I don't know how to check the pin values, I'll 
work up a sequence to check the SECTXCTRL bits for writability.

sln

> 
> I haven't had a chance to test this myself yet since I don't have a system
> that is reproducing this issue. I am including Andre in the "To:" line in
> the hopes that perhaps he can test this to see if it resolves the issue.
> 
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index c42498d..78e7516 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -6128,6 +6128,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
>   #ifdef CONFIG_IXGBE_DCB
>   	ixgbe_init_dcb(adapter);
>   #endif
> +	ixgbe_init_ipsec_offload(adapter);
>   
>   	/* default flow control settings */
>   	hw->fc.requested_mode = ixgbe_fc_full;
> @@ -10537,8 +10538,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   					 NETIF_F_FCOE_MTU;
>   	}
>   #endif /* IXGBE_FCOE */
> -	ixgbe_init_ipsec_offload(adapter);
> -
>   	if (adapter->flags2 & IXGBE_FLAG2_RSC_CAPABLE)
>   		netdev->hw_features |= NETIF_F_LRO;
>   	if (adapter->flags2 & IXGBE_FLAG2_RSC_ENABLED)
> 
