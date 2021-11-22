From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Mon, 22 Nov 2021 12:29:05 +0100
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix NULL pointer dereference
 in i40e_dbg_dump_desc
Message-ID: <20211122112905.30552-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Norbert Zulinski <norbertx.zulinski@intel.com>

When trying to dump VFs VSI RX/TX descriptors
using debugfs there was a crash
due to NULL pointer dereference in i40e_dbg_dump_desc.
Added a check to i40e_dbg_dump_desc that checks if
VSI type is correct for dumping RX/TX descriptors.

Fixes: 02e9c290814c ("i40e: debugfs interface")
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Norbert Zulinski <norbertx.zulinski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 v2: Added missing signed-off-by tag
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 291e61a..2c1b1da 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -553,6 +553,14 @@ static void i40e_dbg_dump_desc(int cnt, int vsi_seid, int ring_id, int desc_n,
 		dev_info(&pf->pdev->dev, "vsi %d not found\n", vsi_seid);
 		return;
 	}
+	if (vsi->type != I40E_VSI_MAIN &&
+	    vsi->type != I40E_VSI_FDIR &&
+	    vsi->type != I40E_VSI_VMDQ2) {
+		dev_info(&pf->pdev->dev,
+			 "vsi %d type %d descriptor rings not available\n",
+			 vsi_seid, vsi->type);
+		return;
+	}
 	if (type == RING_TYPE_XDP && !i40e_enabled_xdp_vsi(vsi)) {
 		dev_info(&pf->pdev->dev, "XDP not enabled on VSI %d\n", vsi_seid);
 		return;
-- 
2.27.0

