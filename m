From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 22 Sep 2021 09:09:39 +0200
Subject: [Intel-wired-lan] [PATCH v1 2/2] e1000e: Fixing packet loss
 issues on new platforms
In-Reply-To: <20210922065542.3780389-1-sasha.neftin@intel.com>
References: <20210922065542.3780389-1-sasha.neftin@intel.com>
Message-ID: <3bbabd03-317f-7bb5-064e-5e2b648ca689@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Sasha,


THank you for the patch.

Am 22.09.21 um 08:55 schrieb Sasha Neftin:

Please use imperative mood in the commit message summary: Fix ?. Maybe:

e1000e: Fix packet loss on Tiger Lake and later

> Update the HW MAC initialization flow. Do not gate DMA clock from
> the modPHY block. Keeping this clock will prevent drop packets sent

dropped

> in burst mode on the Kumeran interface.

What is Kumeran?

Where is the new HW MAC initialization flow documented? The spec or some 
errata?

How can the bug be reproduced?

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213651
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213377
> Fixes: bc7f75fa9788 ("New pci-express e1000 driver");
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 11 ++++++++++-
>   drivers/net/ethernet/intel/e1000e/ich8lan.h |  3 +++
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 66d7196310e2..5e4fc9b4e2ad 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -4813,7 +4813,7 @@ static s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw)
>   static s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
>   {
>   	struct e1000_mac_info *mac = &hw->mac;
> -	u32 ctrl_ext, txdctl, snoop;
> +	u32 ctrl_ext, txdctl, snoop, fflt_dbg;
>   	s32 ret_val;
>   	u16 i;
>   
> @@ -4872,6 +4872,15 @@ static s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
>   		snoop = (u32)~(PCIE_NO_SNOOP_ALL);
>   	e1000e_set_pcie_no_snoop(hw, snoop);
>   
> +	/* Enable workaround for packet loss issue on TGP PCH

Maybe:

> Work around packet loss issue on TGP PCH and later

> +	 * Do not gate DMA clock from the modPHY block
> +	 */
> +	if (mac->type >= e1000_pch_tgp) {
> +		fflt_dbg = er32(FFLT_DBG);

Maybe the variable `ctrl_ext` could be renamed to `tmp` or `tmp32`, and 
reused.

> +		fflt_dbg |= E1000_FFLT_DBG_DONT_GATE_WAKE_DMA_CLK;
> +		ew32(FFLT_DBG, fflt_dbg);
> +	}
> +
>   	ctrl_ext = er32(CTRL_EXT);
>   	ctrl_ext |= E1000_CTRL_EXT_RO_DIS;
>   	ew32(CTRL_EXT, ctrl_ext);
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> index d6a092e5ee74..2504b11c3169 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> @@ -289,6 +289,9 @@
>   /* Proprietary Latency Tolerance Reporting PCI Capability */
>   #define E1000_PCI_LTR_CAP_LPT		0xA8
>   
> +/* Don't gate wake DMA clock */
> +#define E1000_FFLT_DBG_DONT_GATE_WAKE_DMA_CLK	0x1000
> +
>   void e1000e_write_protect_nvm_ich8lan(struct e1000_hw *hw);
>   void e1000e_set_kmrn_lock_loss_workaround_ich8lan(struct e1000_hw *hw,
>   						  bool state);
> 
