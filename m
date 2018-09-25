From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 25 Sep 2018 08:42:18 -0700
Subject: [Intel-wired-lan] [PATCH] iavf: fix a typo
Message-ID: <20180925154218.29651-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Rami Rosen <ramirose@gmail.com>

This trivial patch fixes a typo in iavf.h.

Signed-off-by: Rami Rosen <ramirose@gmail.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index a512f7521841..272d76b733aa 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -342,7 +342,7 @@ struct iavf_adapter {
 	struct iavf_channel_config ch_config;
 	u8 num_tc;
 	struct list_head cloud_filter_list;
-	/* lock to protest access to the cloud filter list */
+	/* lock to protect access to the cloud filter list */
 	spinlock_t cloud_filter_list_lock;
 	u16 num_cloud_filters;
 };
-- 
2.17.1

