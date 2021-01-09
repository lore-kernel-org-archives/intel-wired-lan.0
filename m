From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Sat, 9 Jan 2021 18:57:35 +0200
Subject: [Intel-wired-lan] [PATCH] igc: check return value of ret_val in
 igc_config_fc_after_link_up
In-Reply-To: <X/al3kv9JKN8nhFw@ns.kevlo.org>
References: <X/al3kv9JKN8nhFw@ns.kevlo.org>
Message-ID: <a444142a-564a-163c-8624-fec143fe0027@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/7/2021 08:10, Kevin Lo wrote:
> Check return value from ret_val to make error check actually work.
> 
> Fixes: 4eb8080143a9 ("igc: Add setup link functionality")
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> ---
> diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
> index 09cd0ec7ee87..67b8ffd21d8a 100644
> --- a/drivers/net/ethernet/intel/igc/igc_mac.c
> +++ b/drivers/net/ethernet/intel/igc/igc_mac.c
> @@ -638,7 +638,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>   	}
>   
>   out:
> -	return 0;
> +	return ret_val;
>   }
>   
>   /**
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
Thanks for your patch.
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
