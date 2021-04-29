From: Wang, Haiyue <haiyue.wang@intel.com>
Date: Thu, 29 Apr 2021 15:45:14 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] igb: Add counter to i21x
 doublecheck
In-Reply-To: <1619702916-379862-1-git-send-email-grzegorz.siwik@intel.com>
References: <1619702916-379862-1-git-send-email-grzegorz.siwik@intel.com>
Message-ID: <BN8PR11MB379546E1AF61B4ABB9344EA8F75F9@BN8PR11MB3795.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Grzegorz Siwik
> Sent: Thursday, April 29, 2021 21:29
> To: intel-wired-lan at lists.osuosl.org
> Cc: Siwik, Grzegorz <grzegorz.siwik@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] igb: Add counter to i21x doublecheck
> 
> Add failed_counter to i21x_doublecheck(). There is possibility that
> loop will never end.
> With this patch the loop will stop after maximum 3 retries
> to write to MTA_REGISTER
> 
> Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_mac.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
> index e63ee3c..3cb7e55 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_mac.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
> @@ -492,6 +492,8 @@ static u32 igb_hash_mc_addr(struct e1000_hw *hw, u8 *mc_addr)
>   **/
>  static void igb_i21x_hw_doublecheck(struct e1000_hw *hw)
>  {
> +	const unsigned int failed_cnt_max = 3;
> +	unsigned int failed_cnt = 0;
>  	bool is_failed;
>  	int i;
> 
> @@ -502,10 +504,14 @@ static void igb_i21x_hw_doublecheck(struct e1000_hw *hw)
>  				is_failed = true;
>  				array_wr32(E1000_MTA, i, hw->mac.mta_shadow[i]);
>  				wrfl();
> -				break;
>  			}
>  		}
> -	} while (is_failed);
> +		if (is_failed)
> +			++failed_cnt;
> +	} while (is_failed && failed_cnt < failed_cnt_max);
> +
> +	if (failed_cnt >= failed_cnt_max)
> +		hw_dbg("Failed to update MTA_REGISTER, too many retries");
>  }
> 

May be simple as : - )

int count = 3;



                if (is_failed && --count == 0) {
                        hw_dbg("Failed to update MTA_REGISTER, too many retries");
                        break;
                }
        } while (is_failed);


>  /**
> --
> 1.8.3.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
