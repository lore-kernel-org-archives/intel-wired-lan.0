From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  4 Feb 2016 10:47:56 -0800
Subject: [Intel-wired-lan] [PATCH 3/6] fm10k: base queue scheme covered by
	RSS
In-Reply-To: <1454611679-17424-1-git-send-email-jacob.e.keller@intel.com>
References: <1454611679-17424-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1454611679-17424-3-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In fm10k_set_num_queues, we previously assigned the base template. This
would always be overwritten by either fm10k_set_qos_queues or
fm10k_set_rss_queues. In either case, we don't need the base values, so
we can just remove them.

Change-Id: I8380f6a836e2409da438af258c7b252e39cf108b
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-type: Customization
Complexity: Low
Customer-visible: No
Reviewed-on: https://git-amr-1.devtools.intel.com/gerrit/67458
Tested-by: ND Linux CI Server <nd.linux.ci.server@intel.com>
Reviewed-by: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 134ce4daa994..bd4e6361ff92 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1572,13 +1572,11 @@ static bool fm10k_set_rss_queues(struct fm10k_intfc *interface)
  **/
 static void fm10k_set_num_queues(struct fm10k_intfc *interface)
 {
-	/* Start with base case */
-	interface->num_rx_queues = 1;
-	interface->num_tx_queues = 1;
-
+	/* Attempt to setup QoS and RSS first */
 	if (fm10k_set_qos_queues(interface))
 		return;
 
+	/* If we don't have QoS, just fallback to only RSS. */
 	fm10k_set_rss_queues(interface);
 }
 
-- 
2.7.0.236.gda096a0.dirty

