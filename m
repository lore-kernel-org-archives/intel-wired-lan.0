From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Thu, 4 Nov 2021 11:06:33 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused phy type
In-Reply-To: <20211025071636.818173-1-sasha.neftin@intel.com>
References: <20211025071636.818173-1-sasha.neftin@intel.com>
Message-ID: <77a03195-2650-f2dc-2420-775aaf6a8d71@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/25/2021 10:16, Sasha Neftin wrote:
> _phy_none type not in use. Clean up the code accordingly,
> and get rid of the unused enum line
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_hw.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
> index 587db7483f25..76832e55cbbb 100644
> --- a/drivers/net/ethernet/intel/igc/igc_hw.h
> +++ b/drivers/net/ethernet/intel/igc/igc_hw.h
> @@ -55,7 +55,6 @@ enum igc_mac_type {
>   
>   enum igc_phy_type {
>   	igc_phy_unknown = 0,
> -	igc_phy_none,
>   	igc_phy_i225,
>   };
>   
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>

