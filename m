From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 19 Mar 2021 21:49:43 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] i40e: Fix parameters in
 aq_get_phy_register()
In-Reply-To: <1616158405-95495-1-git-send-email-grzegorz.siwik@intel.com>
References: <1616158405-95495-1-git-send-email-grzegorz.siwik@intel.com>
Message-ID: <a5e0b544180dede5aeae7d40b1a242281373a7a1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-03-19 at 13:53 +0100, Grzegorz Siwik wrote:
> Change parameters order in aq_get_phy_register() due to wrong
> statistics in PHY reported by ethtool. Previosly all PHY statistics 

s/Previosly/Previously

> were
> exactly the same for all interfaces
> Now statistics are reported correctly - different for different
> interfaces
> 
> Fixes: 0514db37dd78 ("i40e: Extend PHY access with page change flag")

Since this has a fixes, I beleive it's for net, but you marked this as
net-next. Which tree are you targeting?

> Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> ---
> v2:
> -Fixed typos in commit message

This is marked as v2, but I don't recall seeing a v1 on this mailing
list.

> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 96d5202..0e92668 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -5480,7 +5480,7 @@ static int i40e_get_module_eeprom(struct
> net_device *netdev,
>  
>  		status = i40e_aq_get_phy_register(hw,
>  				I40E_AQ_PHY_REG_ACCESS_EXTERNAL_MODULE,
> -				true, addr, offset, &value, NULL);
> +				addr, true, offset, &value, NULL);
>  		if (status)
>  			return -EIO;
>  		data[i] = value;
