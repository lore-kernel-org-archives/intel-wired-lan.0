From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 17 Feb 2022 08:24:00 +0200
Subject: [Intel-wired-lan] [PATCH net v2] igc: igc_read_phy_reg_gpy:
 drop premature return
In-Reply-To: <20220216133135.356870-1-vinschen@redhat.com>
References: <20220216133135.356870-1-vinschen@redhat.com>
Message-ID: <063091d1-5d59-3267-b2bd-41bf0dd1ed2e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/16/2022 15:31, Corinna Vinschen wrote:
> igc_read_phy_reg_gpy checks the return value from igc_read_phy_reg_mdic
> and if it's not 0, returns immediately. By doing this, it leaves the HW
> semaphore in the acquired state.
> 
> Drop this premature return statement, the function returns after
> releasing the semaphore immediately anyway.
> 
> Fixes: 5586838fe9ce ("igc: Add code for PHY support")
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> ---
> 
> v2: Add "Fixes:" tag
> 
>   drivers/net/ethernet/intel/igc/igc_phy.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
> index 5cad31c3c7b0..df91d07ce82a 100644
> --- a/drivers/net/ethernet/intel/igc/igc_phy.c
> +++ b/drivers/net/ethernet/intel/igc/igc_phy.c
> @@ -779,8 +779,6 @@ s32 igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data)
>   		if (ret_val)
>   			return ret_val;
>   		ret_val = igc_read_phy_reg_mdic(hw, offset, data);
> -		if (ret_val)
> -			return ret_val;
>   		hw->phy.ops.release(hw);
>   	} else {
>   		ret_val = igc_read_xmdio_reg(hw, (u16)offset, dev_addr,
Thanks Corinna
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
