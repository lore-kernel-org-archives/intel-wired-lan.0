From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 15:56:33 -0700
Subject: [Intel-wired-lan] [PATCH 07/15] fm10k: remove extraneous NULL check
	on l2_accel
In-Reply-To: <1433372201-12007-1-git-send-email-jacob.e.keller@intel.com>
References: <1433372201-12007-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1433372201-12007-7-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

l2_accel was checked for NULL at the top of fm10k_dfwd_del_station, and
we return if it is not defined. Due to this, we already know it can't be
null here so a separate check is meaningless. Discovered via cppcheck.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 4c6b51111566..99228bf46c12 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1333,8 +1333,7 @@ static void fm10k_dfwd_del_station(struct net_device *dev, void *priv)
 	dglort.rss_l = fls(interface->ring_feature[RING_F_RSS].mask);
 	dglort.pc_l = fls(interface->ring_feature[RING_F_QOS].mask);
 	dglort.glort = interface->glort;
-	if (l2_accel)
-		dglort.shared_l = fls(l2_accel->size);
+	dglort.shared_l = fls(l2_accel->size);
 	hw->mac.ops.configure_dglort_map(hw, &dglort);
 
 	/* If table is empty remove it */
-- 
2.1.0

