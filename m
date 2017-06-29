From: Alice Michael <alice.michael@intel.com>
Date: Thu, 29 Jun 2017 04:36:42 -0400
Subject: [Intel-wired-lan] [next PATCH S75-V2 11/12] i40e: 25G FEC status
	improvements
In-Reply-To: <20170629083643.82018-1-alice.michael@intel.com>
References: <20170629083643.82018-1-alice.michael@intel.com>
Message-ID: <20170629083643.82018-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

This patch improves the system log message. The log message will
be expanded to include the FEC mode the FW requested before link
was established.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0c8c07d..fa93c63 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5355,6 +5355,7 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 	char *speed = "Unknown";
 	char *fc = "Unknown";
 	char *fec = "";
+	char *req_fec = "";
 	char *an = "";
 
 	new_speed = vsi->back->hw.phy.link_info.link_speed;
@@ -5416,6 +5417,7 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 	}
 
 	if (vsi->back->hw.phy.link_info.link_speed == I40E_LINK_SPEED_25GB) {
+		req_fec = ", Requested FEC: None";
 		fec = ", FEC: None";
 		an = ", Autoneg: False";
 
@@ -5428,10 +5430,22 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 		else if (vsi->back->hw.phy.link_info.fec_info &
 			 I40E_AQ_CONFIG_FEC_RS_ENA)
 			fec = ", FEC: CL108 RS-FEC";
+
+		/* 'CL108 RS-FEC' should be displayed when RS is requested, or
+		 * both RS and FC are requested
+		 */
+		if (vsi->back->hw.phy.link_info.req_fec_info &
+		    (I40E_AQ_REQUEST_FEC_KR | I40E_AQ_REQUEST_FEC_RS)) {
+			if (vsi->back->hw.phy.link_info.req_fec_info &
+			    I40E_AQ_REQUEST_FEC_RS)
+				req_fec = ", Requested FEC: CL108 RS-FEC";
+			else
+				req_fec = ", Requested FEC: CL74 FC-FEC/BASE-R";
+		}
 	}
 
-	netdev_info(vsi->netdev, "NIC Link is Up, %sbps Full Duplex%s%s, Flow Control: %s\n",
-		    speed, fec, an, fc);
+	netdev_info(vsi->netdev, "NIC Link is Up, %sbps Full Duplex%s%s%s, Flow Control: %s\n",
+		    speed, req_fec, fec, an, fc);
 }
 
 /**
-- 
2.9.3

