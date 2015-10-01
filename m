From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  1 Oct 2015 14:37:36 -0400
Subject: [Intel-wired-lan] [next PATCH S18 3/8] i40e: Fix VEB/VEPA bridge
	mode mismatch issue
In-Reply-To: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443724661-92168-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

Fix i40e_is_vsi_uplink_mode_veb to check if bridge is actually
in VEB mode before allowing LB in the add vsi routine, instead of
unconditionally returning VEB bridge mode.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Change-ID: I162397b1bdd02367735fe9baaeb51465be2a3ce9
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d341f56..a56aefe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8758,12 +8758,22 @@ int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi)
 		return 1;
 
 	veb = pf->veb[vsi->veb_idx];
+	if (!veb) {
+		dev_info(&pf->pdev->dev,
+			 "There is no veb associated with the bridge\n");
+		return -ENOENT;
+	}
+
 	/* Uplink is a bridge in VEPA mode */
-	if (veb && (veb->bridge_mode & BRIDGE_MODE_VEPA))
+	if (veb->bridge_mode & BRIDGE_MODE_VEPA) {
 		return 0;
+	} else {
+		/* Uplink is a bridge in VEB mode */
+		return 1;
+	}
 
-	/* Uplink is a bridge in VEB mode */
-	return 1;
+	/* VEPA is now default bridge, so return 0 */
+	return 0;
 }
 
 /**
-- 
1.9.3

