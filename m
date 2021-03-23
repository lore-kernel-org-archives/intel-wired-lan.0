From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 23 Mar 2021 08:56:37 +0100
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix parameters in
 aq_get_phy_register()
In-Reply-To: <1616425907-12165-1-git-send-email-grzegorz.siwik@intel.com>
References: <1616425907-12165-1-git-send-email-grzegorz.siwik@intel.com>
Message-ID: <95f8be30-1d80-22bc-78be-9265a2816abf@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Grzegorz,


Maybe use something like below as the commit message summary:

> i40e: ethtool: Report correct statistics for each interface

Am 22.03.21 um 16:11 schrieb Grzegorz Siwik:
> Change parameters order in aq_get_phy_register() due to wrong
> statistics in PHY reported by ethtool. Previosly all PHY statistics were

Nit: Previously

> exactly the same for all interfaces
> Now statistics are reported correctly - different for different interfaces
> 
> Fixes: 0514db37dd78 ("i40e: Extend PHY access with page change flag")
> Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> ---
> v2:
> -Changed target tree to net
> ---
>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 96d5202..0e92668 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -5480,7 +5480,7 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
>   
>   		status = i40e_aq_get_phy_register(hw,
>   				I40E_AQ_PHY_REG_ACCESS_EXTERNAL_MODULE,
> -				true, addr, offset, &value, NULL);
> +				addr, true, offset, &value, NULL);
>   		if (status)
>   			return -EIO;
>   		data[i] = value;

The rest looks good.


Kind regards,

Paul
