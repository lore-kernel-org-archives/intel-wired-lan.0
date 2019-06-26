From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 26 Jun 2019 02:20:24 -0700
Subject: [Intel-wired-lan] [PATCH S22 13/16] ice: Don't return error for
 disabling LAN Tx queue that does exist
In-Reply-To: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
Message-ID: <20190626092027.52845-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

Since Tx rings are being managed by FW/NVM, Tx rings might have not been
set up or driver had already wiped them off - In that case, call to
disable LAN Tx queue is being returned as not in existence. This patch
makes sure we don't return unnecessary error for such scenario.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 85fb1e4640ca..8a40de59f94d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2232,6 +2232,9 @@ ice_vsi_stop_tx_rings(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
 		if (status == ICE_ERR_RESET_ONGOING) {
 			dev_dbg(&pf->pdev->dev,
 				"Reset in progress. LAN Tx queues already disabled\n");
+		} else if (status == ICE_ERR_DOES_NOT_EXIST) {
+			dev_dbg(&pf->pdev->dev,
+				"LAN Tx queues does not exist, nothing to disabled\n");
 		} else if (status) {
 			dev_err(&pf->pdev->dev,
 				"Failed to disable LAN Tx queues, error: %d\n",
-- 
2.20.1

