From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Fri, 1 Apr 2022 08:02:29 -0400
Subject: [Intel-wired-lan] [PATCH intel-net] ice: allow creating VFs for
 !CONFIG_NET_SWITCHDEV
In-Reply-To: <20220401125438.292649-1-maciej.fijalkowski@intel.com>
References: <20220401125438.292649-1-maciej.fijalkowski@intel.com>
Message-ID: <Ykbp1W3uBgcCtIYv@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Apr 01, 2022 at 02:54:38PM +0200, Maciej Fijalkowski wrote:
> Currently for !CONFIG_NET_SWITCHDEV kernel builds it is not possible to
> create VFs properly as call to ice_eswitch_configure() returns
> -EOPNOTSUPP for us. This is because CONFIG_ICE_SWITCHDEV depends on
> CONFIG_NET_SWITCHDEV.
> 
> Change the ice_eswitch_configure() implementation for
> !CONFIG_ICE_SWITCHDEV to return 0 instead -EOPNOTSUPP and let
> ice_ena_vfs() finish its work properly.
> 
> CC: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
> index bd58d9d2e565..6a413331572b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
> @@ -52,7 +52,7 @@ static inline void ice_eswitch_update_repr(struct ice_vsi *vsi) { }
>  
>  static inline int ice_eswitch_configure(struct ice_pf *pf)
>  {
> -	return -EOPNOTSUPP;
> +	return 0;
>  }
>  
>  static inline int ice_eswitch_rebuild(struct ice_pf *pf)
> -- 
> 2.27.0
> 
Thanks for this fix!

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
