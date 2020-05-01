From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:52:57 +0000
Subject: [Intel-wired-lan] [PATCH 18/19] igc: Change
 adapter->nfc_rule_lock to mutex
In-Reply-To: <20200424201623.10971-19-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-19-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890A1F8E6B70B4A7A39E919BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 18/19] igc: Change adapter->nfc_rule_lock
> to mutex
> 
> This patch changes adapter->nfc_rule_lock type from spin_lock to mutex
> so we avoid unnecessary busy waiting on lock contention.
> 
> A closer look at the execution context of NFC rule API users shows that
> all of them run in process context. The API users are: ethtool ops,
> igc_configure(), called when interface is brought up by user or reset
> workequeue thread, igc_down(), called when interface is brought down,
> and igc_remove(), called when driver is unloaded.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
> Note that checkpatch.pl reports an issue with this patch. The issue is a false
> positive. There is a comment right above that line referring to the lock.
> 
> Here is the report:
> 
> CHECK: struct mutex definition without comment
> #31: FILE: drivers/net/ethernet/intel/igc/igc.h:193:
> +       struct mutex nfc_rule_lock;
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  2 +-
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 24 ++++++++++----------
>  drivers/net/ethernet/intel/igc/igc_main.c    | 14 ++++++------
>  3 files changed, 20 insertions(+), 20 deletions(-)
> 
Checkpatch complains about not having a comment with the mutex:
---------------------------------------------------------
u1322:[0]/usr/src/kernels/next-queue> git format-patch $item -1 --stdout|./scripts/checkpatch.pl -
CHECK: struct mutex definition without comment
#31: FILE: drivers/net/ethernet/intel/igc/igc.h:193:
+       struct mutex nfc_rule_lock;

total: 0 errors, 0 warnings, 1 checks, 141 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
u1322:[0]/usr/src/kernels/next-queue>
---------------------------------------------------------
Aside from that ...
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
