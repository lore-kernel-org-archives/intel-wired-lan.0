From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:21:25 -0700
Subject: [Intel-wired-lan] [PATCH S18 12/15] ice: Use bitfields where
 possible
In-Reply-To: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172128.27184-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver was converted to not use bool, but it was
neglected that the bools should have been converted to bitfields
as bitfields in software structures are ok, as long as they
use the correct kinds of unsigned types. This avoids
wasting lots of storage space to store single bit values.

One of the change hunks moves a variable lport out of
a group of "combinable" bitfields because all bits of
the u8 lport are valid and the variable can be packed in the
struct in struct holes.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_type.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 77bc0439e108..a862af4cbf78 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -326,6 +326,8 @@ struct ice_port_info {
 	u8 port_state;
 #define ICE_SCHED_PORT_STATE_INIT	0x0
 #define ICE_SCHED_PORT_STATE_READY	0x1
+	u8 lport;
+#define ICE_LPORT_MASK			0xff
 	u16 dflt_tx_vsi_rule_id;
 	u16 dflt_tx_vsi_num;
 	u16 dflt_rx_vsi_rule_id;
@@ -339,11 +341,9 @@ struct ice_port_info {
 	struct ice_dcbx_cfg remote_dcbx_cfg;	/* Peer Cfg */
 	struct ice_dcbx_cfg desired_dcbx_cfg;	/* CEE Desired Cfg */
 	/* LLDP/DCBX Status */
-	u8 dcbx_status;
-	u8 is_sw_lldp;
-	u8 lport;
-#define ICE_LPORT_MASK		0xff
-	u8 is_vf;
+	u8 dcbx_status:3;		/* see ICE_DCBX_STATUS_DIS */
+	u8 is_sw_lldp:1;
+	u8 is_vf:1;
 };
 
 struct ice_switch_info {
-- 
2.20.1

