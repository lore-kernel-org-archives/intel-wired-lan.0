From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 31 Mar 2020 20:55:18 +0000
Subject: [Intel-wired-lan] [PATCH 08/12] igc: Remove
 IGC_MAC_STATE_QUEUE_STEERING
In-Reply-To: <20200318230102.36952-9-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
 <20200318230102.36952-9-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722DEC0@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, March 18, 2020 4:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 08/12] igc: Remove
> IGC_MAC_STATE_QUEUE_STEERING
> 
> The IGC_MAC_STATE_QUEUE_STEERING bit in mac_table[i].state is
> utilized to indicate that frames matching the filter are assigned to
> mac_table[i].queue. This bit is not strictly necessary since we can
> convey the same information as follows: queue == -1 means queue
> assignment is disabled, otherwise it is enabled.
> 
> In addition to make the code simpler, this change fixes some awkward
> situations where we pass a complete misleading 'queue' value such as in
> igc_uc_sync().
> 
> So this patch removes IGC_MAC_STATE_QUEUE_STEERING and also takes the
> opportunity to improve the igc_add_mac_filter documentation.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  3 +-
>  drivers/net/ethernet/intel/igc/igc_main.c | 34 +++++++++++++----------
>  2 files changed, 21 insertions(+), 16 deletions(-)

This one also throws the same basic checkpatch warning as the last:
------------------------------------
u1322:[1]/usr/src/kernels/next-queue> git format-patch $commit -1 --stdout|./scripts/checkpatch.pl -
WARNING: Block comments should align the * on each line
#42: FILE: drivers/net/ethernet/intel/igc/igc_main.c:2245:
+ * In case of success, returns 0. Otherwise, it returns a negative errno code.
+  */

total: 0 errors, 1 warnings, 0 checks, 57 lines checked
-----------------------------------
But otherwise:
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

Jeff if you fix up the last patch go ahead and fix this one up to.

