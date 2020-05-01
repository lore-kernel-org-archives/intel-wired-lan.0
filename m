From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:01:13 +0000
Subject: [Intel-wired-lan] [PATCH 01/19] igc: Remove unused field from
 igc_nfc_filter
In-Reply-To: <20200424201623.10971-2-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-2-andre.guedes@intel.com>
Message-ID: <DM6PR11MB289043495986482C96019E4FBCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 01/19] igc: Remove unused field from
> igc_nfc_filter
> 
> The 'cookie' field is not used anywhere in the code so this patch
> removes it from struct igc_nfc_filter.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
