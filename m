From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 28 Mar 2022 17:53:19 +0000
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix MAC address setting
In-Reply-To: <20220325132524.1765342-1-ivecera@redhat.com>
References: <20220325132524.1765342-1-ivecera@redhat.com>
Message-ID: <CO1PR11MB508954503C974FD6D9E162FCD61D9@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Ivan Vecera <ivecera@redhat.com>
> Sent: Friday, March 25, 2022 6:25 AM
> To: netdev at vger.kernel.org
> Cc: poros <poros@redhat.com>; mschmidt <mschmidt@redhat.com>;
> Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; moderated
> list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; open list <linux-
> kernel at vger.kernel.org>
> Subject: [PATCH net v2] ice: Fix MAC address setting
> 
> Commit 2ccc1c1ccc671b ("ice: Remove excess error variables") merged
> the usage of 'status' and 'err' variables into single one in
> function ice_set_mac_address(). Unfortunately this causes
> a regression when call of ice_fltr_add_mac() returns -EEXIST because
> this return value does not indicate an error in this case but
> value of 'err' remains to be -EEXIST till the end of the function
> and is returned to caller.
> 
> Prior mentioned commit this does not happen because return value of
> ice_fltr_add_mac() was stored to 'status' variable first and
> if it was -EEXIST then 'err' remains to be zero.
> 
> Fix the problem by reset 'err' to zero when ice_fltr_add_mac()
> returns -EEXIST.
> 
> Fixes: 2ccc1c1ccc671b ("ice: Remove excess error variables")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Thanks for the v2. This looks great. Good analysis of how this happened in the commit message, I appreciate that.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index b588d7995631..d755ce07869f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5475,16 +5475,19 @@ static int ice_set_mac_address(struct net_device
> *netdev, void *pi)
> 
>  	/* Add filter for new MAC. If filter exists, return success */
>  	err = ice_fltr_add_mac(vsi, mac, ICE_FWD_TO_VSI);
> -	if (err == -EEXIST)
> +	if (err == -EEXIST) {
>  		/* Although this MAC filter is already present in hardware it's
>  		 * possible in some cases (e.g. bonding) that dev_addr was
>  		 * modified outside of the driver and needs to be restored back
>  		 * to this value.
>  		 */
>  		netdev_dbg(netdev, "filter for MAC %pM already exists\n", mac);
> -	else if (err)
> +
> +		return 0;
> +	} else if (err) {
>  		/* error if the new filter addition failed */
>  		err = -EADDRNOTAVAIL;
> +	}
> 
>  err_update_filters:
>  	if (err) {
> --
> 2.34.1

