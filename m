From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 21 May 2022 08:57:13 +0200
Subject: [Intel-wired-lan] [PATCH] ice: Use correct order for the parameters
 of devm_kcalloc()
Message-ID: <627df513c3acf65f9aa5f43ca2bf7826a73c0c7b.1653116222.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We should have 'n', then 'size', not the opposite.
This is harmless because the 2 values are just multiplied, but having
the correct order silence a (unpublished yet) smatch warning.

While at it use '*tun_seg' instead '*seg'. The both variable have the same
type, so the result is the same, but it lokks more logical.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 5d10c4f84a36..ead6d50fc0ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -852,7 +852,7 @@ ice_create_init_fdir_rule(struct ice_pf *pf, enum ice_fltr_ptype flow)
 	if (!seg)
 		return -ENOMEM;
 
-	tun_seg = devm_kcalloc(dev, sizeof(*seg), ICE_FD_HW_SEG_MAX,
+	tun_seg = devm_kcalloc(dev, ICE_FD_HW_SEG_MAX, sizeof(*tun_seg),
 			       GFP_KERNEL);
 	if (!tun_seg) {
 		devm_kfree(dev, seg);
@@ -1214,7 +1214,7 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 	if (!seg)
 		return -ENOMEM;
 
-	tun_seg = devm_kcalloc(dev, sizeof(*seg), ICE_FD_HW_SEG_MAX,
+	tun_seg = devm_kcalloc(dev, ICE_FD_HW_SEG_MAX, sizeof(*tun_seg),
 			       GFP_KERNEL);
 	if (!tun_seg) {
 		devm_kfree(dev, seg);
-- 
2.34.1

