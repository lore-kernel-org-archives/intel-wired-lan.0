From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:28:02 +0000
Subject: [Intel-wired-lan] [PATCH 10/19] igc: Fix locking issue when
 retrieving NFC rules
In-Reply-To: <20200424201623.10971-11-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-11-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890A829DA89B6B7235B1AF3BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 10/19] igc: Fix locking issue when retrieving
> NFC rules
> 
> Access to NFC rules stored in adapter->nfc_rule_list is protect by
> adapter->nfc_rule_lock. The functions igc_ethtool_get_nfc_rule()
> and igc_ethtool_get_nfc_rules() are missing to hold the lock while
> accessing rule objects.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
