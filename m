From: Bruce Allan <bruce.w.allan@intel.com>
Date: Wed, 28 Oct 2015 16:04:34 -0700
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: cleanup overly long
	lines
Message-ID: <20151028230434.10576.2781.stgit@bwallan-cwp1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c |    2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c  |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
index 2bce474..aee199f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -903,7 +903,7 @@ static void fm10k_mbx_create_disconnect_hdr(struct fm10k_mbx_info *mbx)
 }
 
 /**
- *  fm10k_mbx_create_fake_disconnect_hdr - Generate a false disconnect mailbox header
+ *  fm10k_mbx_create_fake_disconnect_hdr - Generate a false disconnect mbox hdr
  *  @mbx: pointer to mailbox
  *
  *  This function creates a fake disconnect header for loading into remote
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 4172cbb..02a58bf 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1440,9 +1440,10 @@ static void fm10k_update_hw_stats_pf(struct fm10k_hw *hw,
 		xec = fm10k_read_hw_stats_32b(hw, FM10K_STATS_XEC, &stats->xec);
 		vlan_drop = fm10k_read_hw_stats_32b(hw, FM10K_STATS_VLAN_DROP,
 						    &stats->vlan_drop);
-		loopback_drop = fm10k_read_hw_stats_32b(hw,
-							FM10K_STATS_LOOPBACK_DROP,
-							&stats->loopback_drop);
+		loopback_drop =
+			fm10k_read_hw_stats_32b(hw,
+						FM10K_STATS_LOOPBACK_DROP,
+						&stats->loopback_drop);
 		nodesc_drop = fm10k_read_hw_stats_32b(hw,
 						      FM10K_STATS_NODESC_DROP,
 						      &stats->nodesc_drop);

