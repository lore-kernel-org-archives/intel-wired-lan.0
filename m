From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:44:29 +0000
Subject: [Intel-wired-lan] [PATCH 15/19] igc: Fix NFC rules leak when
 driver is unloaded
In-Reply-To: <20200424201623.10971-16-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-16-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28908B3E17B3C551B4ED8F98BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 15/19] igc: Fix NFC rules leak when driver is
> unloaded
> 
> If we have RFC rules in adapter->nfc_rule_list when the IGC driver
> is unloaded, all rules are leaked. This patch fixes the issue by
> introducing the helper igc_flush_nfc_rules() and calling it in
> igc_remove(). It also updates igc_set_features() so is reuses the
> new helper instead of re-implementing it.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 29 +++++++++++++----------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
