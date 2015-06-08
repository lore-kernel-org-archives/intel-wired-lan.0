From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Mon, 8 Jun 2015 22:39:24 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Remember to write
 ixfi changes after modifying
In-Reply-To: <20150608224218.10685.94998.stgit@dcs-desk.jf.intel.com>
References: <20150608224218.10685.94998.stgit@dcs-desk.jf.intel.com>
Message-ID: <F6FB0E698C9B3143BDF729DF2228664691300ECF@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Don Skidmore
> Sent: Monday, June 08, 2015 3:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Remember to write ixfi
> changes after modifying
> 
> This patch corrects a bug in ixgbe_setup_ixfi_x550em where we were
> reading and modifying IXGBE_KRM_LINK_CTRL_1 but forgot to write the
> results back.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> index dc9cdb6..57c40fd 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> @@ -795,7 +795,7 @@ static s32 ixgbe_setup_ixfi_x550em(struct ixgbe_hw
> *hw, ixgbe_link_speed *speed)
>  	}
> 
>  	status = ixgbe_write_iosf_sb_reg_x550(hw,
> -				IXGBE_KRM_RX_TRN_LINKUP_CTRL(hw-
> >bus.lan_id),
> +				IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
>  				IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
>  	if (status)
>  		return status;
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Ignore this resend it is the same patch already in your tree.  I fat-fingered enter while editing my stg mail line.

Sorry,
-Don
