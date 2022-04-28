From: Paul Greenwalt <paul.greenwalt@intel.com>
Date: Thu, 28 Apr 2022 14:11:42 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: fix possible under reporting of
 ethtool Tx and Rx statistics
Message-ID: <20220428211142.806462-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The hardware statistics counters are not cleared during resets so the
drivers first access is to initialize the baseline and then subsequent
reads are for reporting the counters. The statistics counters are read
during the watchdog subtask when the interface is up. If the baseline
is not initialized before the interface is up, then there can be a brief
window in which some traffic can be transmitted/received before the
initial baseline reading takes place.

Directly initialize ethtool statistics in driver open so the baseline will
be initialized when the interface is up, and any dropped packets
incremented before the interface is up won't be reported.

Fixes: 28dc1b86f8ea9 ("ice: ignore dropped packets during init")
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 949669fed7d6..963a5f40e071 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6172,9 +6172,10 @@ static int ice_up_complete(struct ice_vsi *vsi)
 			ice_ptp_link_change(pf, pf->hw.pf_id, true);
 	}
 
-	/* clear this now, and the first stats read will be used as baseline */
-	vsi->stat_offsets_loaded = false;
-
+	/* Perform an initial read of the statistics registers now to
+	 * set the baseline so counters are ready when interface is up
+	 */
+	ice_update_eth_stats(vsi);
 	ice_service_task_schedule(pf);
 
 	return 0;

base-commit: 337f37766fedc611a7f621b8c45cafe3bc265125
-- 
2.31.1

