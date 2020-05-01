From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:54:03 +0000
Subject: [Intel-wired-lan] [PATCH 19/19] igc: Remove igc_nfc_rule_exit()
In-Reply-To: <20200424201623.10971-20-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-20-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28905E8C1981EFF7FF59DBD5BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 19/19] igc: Remove igc_nfc_rule_exit()
> 
> During igc_down(), we call igc_nfc_rule_exit() which traverse the NFC
> rule list disabling filters one by one. Later on in igc_down() flow
> we issue an hardware reset which also clear all filters.  Since we
> already reset the hardware, we don't actually need to disable each
> filter manually. In order to simplify the code, this patch removes
> igc_nfc_rule() altogether.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

