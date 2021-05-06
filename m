From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 May 2021 08:40:06 -0700
Subject: [Intel-wired-lan] [PATCH S59 11/13] ice: downgrade error print to
 debug print
In-Reply-To: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
Message-ID: <20210506154008.12880-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

Failing to add or remove LLDP filter doesn't seem to be a fatal
error, so downgrade the dev_err message to a dev_dbg message.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 20daa8c8fb07..3291fe194ba1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2237,7 +2237,7 @@ void ice_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
 	}
 
 	if (status)
-		dev_err(dev, "Fail %s %s LLDP rule on VSI %i error: %s\n",
+		dev_dbg(dev, "Fail %s %s LLDP rule on VSI %i error: %s\n",
 			create ? "adding" : "removing", tx ? "TX" : "RX",
 			vsi->vsi_num, ice_stat_str(status));
 }
-- 
2.20.1

