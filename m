From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:42:56 +0000
Subject: [Intel-wired-lan] [PATCH 14/19] igc: Refactor
 igc_ethtool_update_nfc_rule()
In-Reply-To: <20200424201623.10971-15-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-15-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28909D7CF0FC6DDF2BEE554DBCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 14/19] igc: Refactor
> igc_ethtool_update_nfc_rule()
> 
> Current implementation of igc_ethtool_update_nfc_rule() is a bit
> convoluted since it handles too many things: rule lookup, deletion
> and addition. This patch breaks it into three functions so we simplify
> the code and improve code reuse.
> 
> Code related to rule lookup is refactored out to a new function called
> igc_get_nfc_rule().
> 
> Code related to rule addition is refactored out to a new function called
> igc_add_nfc_rule(). This function enables the rule in hardware and adds
> it to the adapter's list.
> 
> Code related to rule deletion is refactored out to a new function called
> igc_del_nfc_rule(). This function disables the rule in hardware, removes
> it from adapter's list, and deletes it.
> 
> As a byproduct of this refactoring, igc_enable_nfc_rule() and
> igc_disable_nfc_rule() are moved to igc_main.c since they are not used
> in igc_ethtool.c anymore, and igc_restore_nfc_rules() and igc_nfc_rule_
> exit() are moved around to avoid forward declaration.
> 
> Also, since this patch already touches igc_ethtool_get_nfc_rule(), it
> takes the opportunity to remove the 'match_flags' check. Empty flags
> are not allowed to be added so no need to check that.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  18 +-
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 138 ++-----------
>  drivers/net/ethernet/intel/igc/igc_main.c    | 205 ++++++++++++++++---
>  3 files changed, 195 insertions(+), 166 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

