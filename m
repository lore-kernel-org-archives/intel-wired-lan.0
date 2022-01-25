From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 25 Jan 2022 19:55:31 +0100
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Fix possible HW unit
 hang after an s0ix exit
In-Reply-To: <20220125173123.962540-1-sasha.neftin@intel.com>
References: <20220125173123.962540-1-sasha.neftin@intel.com>
Message-ID: <a223b8a3-e54f-0a50-1aba-05b8a09e1ace@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Sasha,


Thank you for the patch.

Am 25.01.22 um 18:31 schrieb Sasha Neftin:
> Disable the OEM bit/Gig Disable/restart AN impact and disable the PHY
> (LCD) reset during power management flows.

What does LCD mean?

> Fix possible HW unit hangs on the s0ix exit on some corporate ADL
> platforms.

As this issue caused a lot of grieve and will affect thousands of 
devices, please elaborate much more. Please start with the problem 
description, and then explain, why the fix (first sentence) is supposed 
to work and even specify in what datasheet this behavior is defined.

Lastly, please list, how  this patch was tested (device, ME firmware 
version, how many cycles).

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=214821
> Fixes: 3e55d231716e ("e1000e: Add handshake with the CSME to support S0ix)
> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Suggested-by: Nir Efrati <nir.efrati@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/net/ethernet/intel/e1000e/hw.h      |  1 +
>   drivers/net/ethernet/intel/e1000e/ich8lan.c |  4 ++++
>   drivers/net/ethernet/intel/e1000e/ich8lan.h |  1 +
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 26 +++++++++++++++++++++
>   4 files changed, 32 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
> index bcf680e83811..13382df2f2ef 100644
> --- a/drivers/net/ethernet/intel/e1000e/hw.h
> +++ b/drivers/net/ethernet/intel/e1000e/hw.h
> @@ -630,6 +630,7 @@ struct e1000_phy_info {
>   	bool disable_polarity_correction;
>   	bool is_mdix;
>   	bool polarity_correction;
> +	bool reset_disable;

Above `disable_polarity_correction` is used as a name. Maybe use 
`disable_reset` then. As you add comments with LCD around the variable 
usage, maybe even `disable_lcd_reset`.

>   	bool speed_downgraded;
>   	bool autoneg_wait_to_complete;
>   };
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index c908c84b86d2..e298da712758 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -2050,6 +2050,10 @@ static s32 e1000_check_reset_block_ich8lan(struct e1000_hw *hw)
>   	bool blocked = false;
>   	int i = 0;
>   
> +	/* Check the PHY (LCD) reset flag */
> +	if (hw->phy.reset_disable)
> +		return true;
> +

When/how is `e1000_check_reset_block_ich8lan()` called in relation to 
`e1000e_pm_suspend()` and `e1000e_pm_resume()`?

>   	while ((blocked = !(er32(FWSM) & E1000_ICH_FWSM_RSPCIPHY)) &&
>   	       (i++ < 30))
>   		usleep_range(10000, 11000);
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> index 2504b11c3169..638a3ddd7ada 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> @@ -271,6 +271,7 @@
>   #define I217_CGFREG_ENABLE_MTA_RESET	0x0002
>   #define I217_MEMPWR			PHY_REG(772, 26)
>   #define I217_MEMPWR_DISABLE_SMB_RELEASE	0x0010
> +#define I217_MEMPWR_MOEM		0x1000

Be clear and use `MEMPWR_MASK_OEM`?

>   /* Receive Address Initial CRC Calculation */
>   #define E1000_PCH_RAICC(_n)	(0x05F50 + ((_n) * 4))
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 6fb3437f68e0..fa06f68c8c80 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6987,8 +6987,21 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
>   	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
>   	struct e1000_adapter *adapter = netdev_priv(netdev);
>   	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct e1000_hw *hw = &adapter->hw;
> +	u16 phy_data;
>   	int rc;
>   
> +	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID &&
> +	    hw->mac.type >= e1000_pch_adp) {
> +		/* Mask OEM Bits / Gig Disable / Restart AN (772_26[12] = 1) */

What is AN?

> +		e1e_rphy(hw, I217_MEMPWR, &phy_data);
> +		phy_data |= I217_MEMPWR_MOEM;
> +		e1e_wphy(hw, I217_MEMPWR, phy_data);
> +
> +		/* Disable LCD reset */
> +		hw->phy.reset_disable = true;
> +	}
> +
>   	e1000e_flush_lpic(pdev);
>   
>   	e1000e_pm_freeze(dev);
> @@ -7010,6 +7023,8 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
>   	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
>   	struct e1000_adapter *adapter = netdev_priv(netdev);
>   	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct e1000_hw *hw = &adapter->hw;
> +	u16 phy_data;
>   	int rc;
>   
>   	/* Introduce S0ix implementation */
> @@ -7020,6 +7035,17 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
>   	if (rc)
>   		return rc;
>   
> +	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID &&
> +	    hw->mac.type >= e1000_pch_adp) {
> +		/* Unmask OEM Bits / Gig Disable / Restart AN 772_26[12] = 0 */
> +		e1e_rphy(hw, I217_MEMPWR, &phy_data);
> +		phy_data &= ~I217_MEMPWR_MOEM;
> +		e1e_wphy(hw, I217_MEMPWR, phy_data);
> +
> +		/* Enable LCD reset */
> +		hw->phy.reset_disable = false;
> +	}
> +
>   	return e1000e_pm_thaw(dev);
>   }
>   


Kind regards,

Paul
