From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Mon, 31 Jan 2022 12:51:07 +0200
Subject: [Intel-wired-lan] [PATCH net] net: e1000e: Recover at least
 in-memory copy of NVM checksum
In-Reply-To: <20220127150807.26448-1-tbogendoerfer@suse.de>
References: <20220127150807.26448-1-tbogendoerfer@suse.de>
Message-ID: <d32ac7da-f460-6d7a-5f7f-9c9d873bf393@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/27/2022 17:08, Thomas Bogendoerfer wrote:
> Commit 4051f68318ca ("e1000e: Do not take care about recovery NVM
> checksum") causes a regression for systems with a broken NVM checksum
> and hardware which is not able to update the NVM. Before the change the
> in-memory copy was correct even the NVM update doesn't work, which is
> good enough for the driver to work again.
> 
> See
> 
> https://bugzilla.opensuse.org/show_bug.cgi?id=1191663
> 
> for more details.
> 
> This patch reverts the change and moves the check for hardware without
> NVM update capability right before the real flash update.
> 
> Fixes: 4051f68318ca ("e1000e: Do not take care about recovery NVM checksum")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 5e4fc9b4e2ad..613a60f24ba6 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -3808,6 +3808,9 @@ static s32 e1000_update_nvm_checksum_spt(struct e1000_hw *hw)
>   	if (nvm->type != e1000_nvm_flash_sw)
>   		goto out;
>   
> +	if (hw->mac.type >= e1000_pch_cnp)
> +		goto out;
> +
>   	nvm->ops.acquire(hw);
>   
>   	/* We're writing to the opposite bank so if we're on bank 1,
> @@ -4136,17 +4139,13 @@ static s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
>   		return ret_val;
>   
>   	if (!(data & valid_csum_mask)) {
> -		e_dbg("NVM Checksum Invalid\n");
> -
> -		if (hw->mac.type < e1000_pch_cnp) {
I meant: change hw->mac.type < e1000_pch_cnp to hw->mac.type < e1000_pch_tgp
> -			data |= valid_csum_mask;
> -			ret_val = e1000_write_nvm(hw, word, 1, &data);
> -			if (ret_val)
> -				return ret_val;
> -			ret_val = e1000e_update_nvm_checksum(hw);
> -			if (ret_val)
> -				return ret_val;
> -		}
Hello Thomas,
For security reasons starting from the TGL platform SPI controller will 
be locked for SW access. I've double-checked with our HW architect, not 
from SPT, from TGP. So, first, we can change the mac type e1000_pch_cnp 
to e1000_pch_tgp (as fix for initial patch)
Do we want (second) to allow HW initialization with the "wrong" NVM 
checksum? It could cause unexpected (HW) behavior in the future. Even if 
you will "recover" check in shadow RAM - there is no guarantee that NVM 
is good.
> +		data |= valid_csum_mask;
> +		ret_val = e1000_write_nvm(hw, word, 1, &data);
> +		if (ret_val)
> +			return ret_val;
> +		ret_val = e1000e_update_nvm_checksum(hw);
> +		if (ret_val)
> +			return ret_val;
>   	}
>   
>   	return e1000e_validate_nvm_checksum_generic(hw);
Thanks,
Sasha
