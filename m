From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:41:29 +0000
Subject: [Intel-wired-lan] [PATCH 13/19] igc: Fix NFC rules restoration
In-Reply-To: <20200424201623.10971-14-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-14-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28905AF4268AFDFA1DA8A771BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 13/19] igc: Fix NFC rules restoration
> 
> When network interface is brought up, the driver re-enables the NFC
> rules previously configured. However, this is done in reverse order
> the rules were added and hardware filters are configured differently.
> 
> For example, consider the following rules:
> 
> $ ethtool -N eth0 flow-type ether dst 00:00:00:00:00:AA queue 0
> $ ethtool -N eth0 flow-type ether dst 00:00:00:00:00:BB queue 1
> $ ethtool -N eth0 flow-type ether dst 00:00:00:00:00:CC queue 2
> $ ethtool -N eth0 flow-type ether dst 00:00:00:00:00:DD queue 3
> 
> RAL/RAH registers are configure so filter index 1 has address ending
> with AA, filter index 2 has address ending in BB, and so on.
> 
> If we bring the interface down and up again, RAL/RAH registers are
> configured so filter index 1 has address ending in DD, filter index 2
> has CC, and so on. IOW, in reverse order we had before bringing the
> interface down.
> 
> This issue can be fixed by traversing adapter->nfc_rule_list in
> backwards when restoring the rules. Since hlist doesn't support
> backwards traversal, this patch replaces it by list_head and fixes
> igc_restore_nfc_rules() accordingly.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  4 ++--
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 19 ++++++++-----------
>  drivers/net/ethernet/intel/igc/igc_main.c    | 16 +++++++++-------
>  3 files changed, 19 insertions(+), 20 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

