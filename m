From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 10 Jun 2020 08:22:12 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Refactor the
 igc_power_up_link()
In-Reply-To: <20200610061227.3315-1-sasha.neftin@intel.com>
References: <20200610061227.3315-1-sasha.neftin@intel.com>
Message-ID: <a7d7a8c2-2ad1-2ac4-dc7c-e8237a34739c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Sasha,


Thank you for the patch.

Am 10.06.20 um 08:12 schrieb Sasha Neftin:
> PHY of the i225 device support only copper mode.
> There is no point to check media type in the
> igc_power_up_link() method.

One nit regarding the commit message summary. *Refactor* very generic. 
Could you use something like:

 > igc: Remove unneeded check for copper media type

> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index af5e1686f7f2..83c94fa58c40 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -115,8 +115,7 @@ static void igc_power_up_link(struct igc_adapter *adapter)
>   {
>   	igc_reset_phy(&adapter->hw);
>   
> -	if (adapter->hw.phy.media_type == igc_media_type_copper)
> -		igc_power_up_phy_copper(&adapter->hw);
> +	igc_power_up_phy_copper(&adapter->hw);
>   
>   	igc_setup_link(&adapter->hw);
>   }

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
