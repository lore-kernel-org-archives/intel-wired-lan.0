From: Jiri Pirko <jiri@resnulli.us>
Date: Sun, 24 Jun 2018 10:38:37 +0200
Subject: [Intel-wired-lan] [patch net-next 1/3] bnxt: simplify cls_flower
 command switch and handle default case
In-Reply-To: <20180624083839.1692-1-jiri@resnulli.us>
References: <20180624083839.1692-1-jiri@resnulli.us>
Message-ID: <20180624083839.1692-2-jiri@resnulli.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jiri Pirko <jiri@mellanox.com>

Currently the default case is not handled, which with future command
introductions would introduce a warning. So handle it and make the
switch a bit simplier removing unneeded "rc" variable.

Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 795f45024c20..d0699f39ba34 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -1544,22 +1544,16 @@ void bnxt_tc_flow_stats_work(struct bnxt *bp)
 int bnxt_tc_setup_flower(struct bnxt *bp, u16 src_fid,
 			 struct tc_cls_flower_offload *cls_flower)
 {
-	int rc = 0;
-
 	switch (cls_flower->command) {
 	case TC_CLSFLOWER_REPLACE:
-		rc = bnxt_tc_add_flow(bp, src_fid, cls_flower);
-		break;
-
+		return bnxt_tc_add_flow(bp, src_fid, cls_flower);
 	case TC_CLSFLOWER_DESTROY:
-		rc = bnxt_tc_del_flow(bp, cls_flower);
-		break;
-
+		return bnxt_tc_del_flow(bp, cls_flower);
 	case TC_CLSFLOWER_STATS:
-		rc = bnxt_tc_get_flow_stats(bp, cls_flower);
-		break;
+		return bnxt_tc_get_flow_stats(bp, cls_flower);
+	default:
+		return -EOPNOTSUPP;
 	}
-	return rc;
 }
 
 static const struct rhashtable_params bnxt_tc_flow_ht_params = {
-- 
2.14.4

