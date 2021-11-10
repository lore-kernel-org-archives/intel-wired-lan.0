From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 10 Nov 2021 10:50:23 +0300
Subject: [Intel-wired-lan] [PATCH net-next] ice: Remove unnecessary casts
Message-ID: <20211110075023.GC5176@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The "bitmap" variable is already an unsigned long so there is no need
for this cast.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index ce3c7bded4cb..61c3f88d6ed2 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -2661,11 +2661,9 @@ ice_cfg_agg(struct ice_port_info *pi, u32 agg_id, enum ice_agg_type agg_type,
 	enum ice_status status;
 
 	mutex_lock(&pi->sched_lock);
-	status = ice_sched_cfg_agg(pi, agg_id, agg_type,
-				   (unsigned long *)&bitmap);
+	status = ice_sched_cfg_agg(pi, agg_id, agg_type, &bitmap);
 	if (!status)
-		status = ice_save_agg_tc_bitmap(pi, agg_id,
-						(unsigned long *)&bitmap);
+		status = ice_save_agg_tc_bitmap(pi, agg_id, &bitmap);
 	mutex_unlock(&pi->sched_lock);
 	return status;
 }
-- 
2.20.1

