From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 13 Feb 2019 10:43:46 +0200
Subject: [Intel-wired-lan] [PATCH v2] intel-ethernet: warn when fatal
 read failure happens
In-Reply-To: <1550025714-76215-1-git-send-email-feng.tang@intel.com>
References: <1550025714-76215-1-git-send-email-feng.tang@intel.com>
Message-ID: <880e19b1-1fda-2ddd-4a05-6ac748ecf9e9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/13/2019 04:41, Feng Tang wrote:
> Failed in read the HW register is very serious for igb/igc driver,
> as its hw_addr will be set to NULL and cause the adapter be seen as
> "REMOVED".
> 
> We saw the error only a few times in the MTBF test for suspend/resume,
> but can hardly get any useful info to debug.
> 
> Adding WARN() so that we can get the necessary information about
> where and how it happens, and use it for root causing and fixing
> this "PCIe link lost issue"
> 
> This affects igb, igc.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> ---
> Changelog:
> 
>    v2: add "\n" to the warning message as suggested by Sasha Neftin
> 
>   drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>   drivers/net/ethernet/intel/igc/igc_main.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 7137e7f..e3177e5 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -753,6 +753,7 @@ u32 igb_rd32(struct e1000_hw *hw, u32 reg)
>   		struct net_device *netdev = igb->netdev;
>   		hw->hw_addr = NULL;
>   		netdev_err(netdev, "PCIe link lost\n");
> +		WARN(1, "igb: Failed to read reg 0x%x!\n", reg);
>   	}
>   
>   	return value;
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index f201830..f0af812 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -3496,6 +3496,7 @@ u32 igc_rd32(struct igc_hw *hw, u32 reg)
>   		hw->hw_addr = NULL;
>   		netif_device_detach(netdev);
>   		netdev_err(netdev, "PCIe link lost, device now detached\n");
> +		WARN(1, "igc: Failed to read reg 0x%x!\n", reg); >   	}
>   
>   	return value;
> 
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
