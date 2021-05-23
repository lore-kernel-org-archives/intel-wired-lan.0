From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Sun, 23 May 2021 08:47:27 +0300
Subject: [Intel-wired-lan] [PATCH] igc: change default return of
 igc_read_phy_reg()
In-Reply-To: <20210521195019.2078661-1-trix@redhat.com>
References: <20210521195019.2078661-1-trix@redhat.com>
Message-ID: <85d1b413-3ab3-6cee-4197-785b0c099340@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/21/2021 22:50, trix at redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Static analysis reports this problem
> 
> igc_main.c:4944:20: warning: The left operand of '&'
>    is a garbage value
>      if (!(phy_data & SR_1000T_REMOTE_RX_STATUS) &&
>            ~~~~~~~~ ^
Tom, thanks for this patch. I believe the same static analysis problem 
should be with the 'igb_read_phy_reg' method:
https://elixir.bootlin.com/linux/v5.13-rc1/source/drivers/net/ethernet/intel/igb/igb.h#L769
> 
> pyy_data is set by the call to igc_read_phy_reg() only if
%s/pyy_data/phy_data/gc (typo)
> there is a read_reg() op, else it is unset and a 0 is
> returned.  Change the return to -EOPNOTSUPP.
> 
> Fixes: 208983f099d9 ("igc: Add watchdog")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index b6d3277c6f520..71100ee7afbee 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -577,7 +577,7 @@ static inline s32 igc_read_phy_reg(struct igc_hw *hw, u32 offset, u16 *data)
>   	if (hw->phy.ops.read_reg)
>   		return hw->phy.ops.read_reg(hw, offset, data);
>   
> -	return 0;
> +	return -EOPNOTSUPP;
>   }
>   
>   void igc_reinit_locked(struct igc_adapter *);
> 
Thanks,
Sasha
