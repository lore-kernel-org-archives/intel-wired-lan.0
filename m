From: Mark Pearson <markpearson@lenovo.com>
Date: Wed, 22 Sep 2021 09:56:50 -0400
Subject: [Intel-wired-lan] [PATCH v1 2/2] e1000e: Fixing packet loss
 issues on new platforms
In-Reply-To: <0631366b-808d-f52b-8cf6-2a2cbdd636d2@intel.com>
References: <20210922065542.3780389-1-sasha.neftin@intel.com>
 <0631366b-808d-f52b-8cf6-2a2cbdd636d2@intel.com>
Message-ID: <7dba27f2-b94e-0dcd-48e6-62a66ce7662b@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Sasha,

Confirmed this fixes the problem on my X13 G2

Tested-by: Mark Pearson <markpearson@lenovo.com>

Mark

On 2021-09-22 09:29, Sasha Neftin wrote:
> 
> 
> 
> -------- Forwarded Message --------
> Subject: [PATCH v1 2/2] e1000e: Fixing packet loss issues on new platforms
> Date: Wed, 22 Sep 2021 09:55:42 +0300
> From: Sasha Neftin <sasha.neftin@intel.com>
> To: intel-wired-lan at lists.osuosl.org
> CC: Sasha Neftin <sasha.neftin@intel.com>
> 
> Update the HW MAC initialization flow. Do not gate DMA clock from
> the modPHY block. Keeping this clock will prevent drop packets sent
> in burst mode on the Kumeran interface.
> 
> Bugzilla: 
> https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D213651&amp;data=04%7C01%7Cmarkpearson%40lenovo.com%7Cb5b073b630794c8ff7b908d97dcd03a3%7C5c7d0b28bdf8410caa934df372b16203%7C1%7C0%7C637679141742309105%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=1TJGrHWxUne7m%2BOPaAw5TuMAJHzOldg5Ws4xSY2Ew40%3D&amp;reserved=0 
> 
> Bugzilla: 
> https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D213377&amp;data=04%7C01%7Cmarkpearson%40lenovo.com%7Cb5b073b630794c8ff7b908d97dcd03a3%7C5c7d0b28bdf8410caa934df372b16203%7C1%7C0%7C637679141742319058%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=BRuJa4pf%2FhTau%2BfDY1lMOI%2F0wCMUYh5bB%2FJHZjTJmQw%3D&amp;reserved=0 
> 
> Fixes: bc7f75fa9788 ("New pci-express e1000 driver");
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  ?drivers/net/ethernet/intel/e1000e/ich8lan.c | 11 ++++++++++-
>  ?drivers/net/ethernet/intel/e1000e/ich8lan.h |? 3 +++
>  ?2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c 
> b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 66d7196310e2..5e4fc9b4e2ad 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -4813,7 +4813,7 @@ static s32 e1000_reset_hw_ich8lan(struct e1000_hw 
> *hw)
>  ?static s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
>  ?{
>  ???? struct e1000_mac_info *mac = &hw->mac;
> -??? u32 ctrl_ext, txdctl, snoop;
> +??? u32 ctrl_ext, txdctl, snoop, fflt_dbg;
>  ???? s32 ret_val;
>  ???? u16 i;
>  ?@@ -4872,6 +4872,15 @@ static s32 e1000_init_hw_ich8lan(struct 
> e1000_hw *hw)
>  ???????? snoop = (u32)~(PCIE_NO_SNOOP_ALL);
>  ???? e1000e_set_pcie_no_snoop(hw, snoop);
>  ?+??? /* Enable workaround for packet loss issue on TGP PCH
> +???? * Do not gate DMA clock from the modPHY block
> +???? */
> +??? if (mac->type >= e1000_pch_tgp) {
> +??????? fflt_dbg = er32(FFLT_DBG);
> +??????? fflt_dbg |= E1000_FFLT_DBG_DONT_GATE_WAKE_DMA_CLK;
> +??????? ew32(FFLT_DBG, fflt_dbg);
> +??? }
> +
>  ???? ctrl_ext = er32(CTRL_EXT);
>  ???? ctrl_ext |= E1000_CTRL_EXT_RO_DIS;
>  ???? ew32(CTRL_EXT, ctrl_ext);
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h 
> b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> index d6a092e5ee74..2504b11c3169 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> @@ -289,6 +289,9 @@
>  ?/* Proprietary Latency Tolerance Reporting PCI Capability */
>  ?#define E1000_PCI_LTR_CAP_LPT??????? 0xA8
>  ?+/* Don't gate wake DMA clock */
> +#define E1000_FFLT_DBG_DONT_GATE_WAKE_DMA_CLK??? 0x1000
> +
>  ?void e1000e_write_protect_nvm_ich8lan(struct e1000_hw *hw);
>  ?void e1000e_set_kmrn_lock_loss_workaround_ich8lan(struct e1000_hw *hw,
>  ?????????????????????????? bool state);
