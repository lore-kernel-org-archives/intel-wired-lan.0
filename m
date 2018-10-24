From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 24 Oct 2018 13:20:02 +0300
Subject: [Intel-wired-lan] [PATCH net-next] igc: Remove set but not used
 variables 'ctrl_ext, link_mode'
In-Reply-To: <1539952830-187358-1-git-send-email-yuehaibing@huawei.com>
References: <1539952830-187358-1-git-send-email-yuehaibing@huawei.com>
Message-ID: <8bb1076e-fc8a-0b8e-b6d2-0a14d13db8d3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/19/2018 15:40, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/intel/igc/igc_base.c: In function 'igc_init_phy_params_base':
> drivers/net/ethernet/intel/igc/igc_base.c:240:6: warning:
>   variable 'ctrl_ext' set but not used [-Wunused-but-set-variable]
>    u32 ctrl_ext;
>    
> drivers/net/ethernet/intel/igc/igc_base.c: In function 'igc_get_invariants_base':
> drivers/net/ethernet/intel/igc/igc_base.c:290:6: warning:
>   variable 'link_mode' set but not used [-Wunused-but-set-variable]
>    u32 link_mode = 0;
> 
> It never used since introduction in
> commit c0071c7aa5fe ("igc: Add HW initialization code")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> I'm not sure that reading IGC_CTRL_EXT is necessary.
> ---
>   drivers/net/ethernet/intel/igc/igc_base.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
> index 832da609..df40af7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.c
> +++ b/drivers/net/ethernet/intel/igc/igc_base.c
> @@ -237,7 +237,6 @@ static s32 igc_init_phy_params_base(struct igc_hw *hw)
>   {
>   	struct igc_phy_info *phy = &hw->phy;
>   	s32 ret_val = 0;
> -	u32 ctrl_ext;
>   
>   	if (hw->phy.media_type != igc_media_type_copper) {
>   		phy->type = igc_phy_none;
> @@ -247,8 +246,6 @@ static s32 igc_init_phy_params_base(struct igc_hw *hw)
>   	phy->autoneg_mask	= AUTONEG_ADVERTISE_SPEED_DEFAULT_2500;
>   	phy->reset_delay_us	= 100;
>   
> -	ctrl_ext = rd32(IGC_CTRL_EXT);
> -
>   	/* set lan id */
>   	hw->bus.func = (rd32(IGC_STATUS) & IGC_STATUS_FUNC_MASK) >>
>   			IGC_STATUS_FUNC_SHIFT;
> @@ -287,8 +284,6 @@ static s32 igc_init_phy_params_base(struct igc_hw *hw)
>   static s32 igc_get_invariants_base(struct igc_hw *hw)
>   {
>   	struct igc_mac_info *mac = &hw->mac;
> -	u32 link_mode = 0;
> -	u32 ctrl_ext = 0;
>   	s32 ret_val = 0;
>   
>   	switch (hw->device_id) {
> @@ -302,9 +297,6 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
>   
>   	hw->phy.media_type = igc_media_type_copper;
>   
> -	ctrl_ext = rd32(IGC_CTRL_EXT);
> -	link_mode = ctrl_ext & IGC_CTRL_EXT_LINK_MODE_MASK;
> -
>   	/* mac initialization and operations */
>   	ret_val = igc_init_mac_params_base(hw);
>   	if (ret_val)
> 
Thanks for the patch. Good.

Acked-by: Sasha Neftin <sasha.neftin@intel.com>
