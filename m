From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  3 Sep 2015 17:19:00 -0400
Subject: [Intel-wired-lan] [next PATCH S15 13/15] i40e: remove unnecessary
	string copy operations
In-Reply-To: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441315142-173025-14-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Save a little stack space and remove unnecessary strncpy() with a little
string pointer.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Id2719d34710bfc273d3bb445fec085cd04276e88
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4bcf4a1..848482b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4896,8 +4896,8 @@ out:
  */
 void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 {
-	char speed[SPEED_SIZE] = "Unknown";
-	char fc[FC_SIZE] = "RX/TX";
+	char *speed = "Unknown";
+	char *fc = "Unknown";
 
 	if (vsi->current_isup == isup)
 		return;
@@ -4918,19 +4918,19 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 
 	switch (vsi->back->hw.phy.link_info.link_speed) {
 	case I40E_LINK_SPEED_40GB:
-		strlcpy(speed, "40 Gbps", SPEED_SIZE);
+		speed = "40 G";
 		break;
 	case I40E_LINK_SPEED_20GB:
-		strncpy(speed, "20 Gbps", SPEED_SIZE);
+		speed = "20 G";
 		break;
 	case I40E_LINK_SPEED_10GB:
-		strlcpy(speed, "10 Gbps", SPEED_SIZE);
+		speed = "10 G";
 		break;
 	case I40E_LINK_SPEED_1GB:
-		strlcpy(speed, "1000 Mbps", SPEED_SIZE);
+		speed = "1000 M";
 		break;
 	case I40E_LINK_SPEED_100MB:
-		strncpy(speed, "100 Mbps", SPEED_SIZE);
+		speed = "100 M";
 		break;
 	default:
 		break;
@@ -4938,20 +4938,20 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 
 	switch (vsi->back->hw.fc.current_mode) {
 	case I40E_FC_FULL:
-		strlcpy(fc, "RX/TX", FC_SIZE);
+		fc = "RX/TX";
 		break;
 	case I40E_FC_TX_PAUSE:
-		strlcpy(fc, "TX", FC_SIZE);
+		fc = "TX";
 		break;
 	case I40E_FC_RX_PAUSE:
-		strlcpy(fc, "RX", FC_SIZE);
+		fc = "RX";
 		break;
 	default:
-		strlcpy(fc, "None", FC_SIZE);
+		fc = "None";
 		break;
 	}
 
-	netdev_info(vsi->netdev, "NIC Link is Up %s Full Duplex, Flow Control: %s\n",
+	netdev_info(vsi->netdev, "NIC Link is Up %sbps Full Duplex, Flow Control: %s\n",
 		    speed, fc);
 }
 
-- 
1.9.3

