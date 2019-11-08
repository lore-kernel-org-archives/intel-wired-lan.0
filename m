From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  8 Nov 2019 06:23:18 -0800
Subject: [Intel-wired-lan] [PATCH S33 02/15] ice: Correct capabilities
 reporting of max TCs
In-Reply-To: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
Message-ID: <20191108142331.10221-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Firmware always returns 8 as the max number of supported TCs. However on
devices with more than 4 ports, the maximum number of TCs per port is
limited to 4. Check and, if necessary, correct the reporting of
capabilities for devices with more than 4 ports.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index e92eaec19c83..fb1d930470c7 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1783,6 +1783,18 @@ ice_parse_caps(struct ice_hw *hw, void *buf, u32 cap_count,
 			break;
 		}
 	}
+
+	/* Re-calculate capabilities that are dependent on the number of
+	 * physical ports; i.e. some features are not supported or function
+	 * differently on devices with more than 4 ports.
+	 */
+	if (hw->dev_caps.num_funcs > 4) {
+		/* Max 4 TCs per port */
+		caps->maxtc = 4;
+		ice_debug(hw, ICE_DBG_INIT,
+			  "%s: maxtc = %d (based on #ports)\n", prefix,
+			  caps->maxtc);
+	}
 }
 
 /**
-- 
2.20.1

