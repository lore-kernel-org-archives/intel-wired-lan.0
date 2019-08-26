From: Alice Michael <alice.michael@intel.com>
Date: Mon, 26 Aug 2019 11:16:53 -0700
Subject: [Intel-wired-lan] [next PATCH S9 5/7] i40e: fix missed "Negotiated"
 string in i40e_print_link_message()
In-Reply-To: <20190826181655.15106-1-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
Message-ID: <20190826181655.15106-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

The "Negotiated" string in i40e_print_link_message() function was missed.
This string has been added to the dmesg and small refactoring done removing
common substrings and unifying link status message format.
Without this patch it was not clear that FEC is related to negotiated FEC.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ed8e62cb5417..161663de09ef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6564,19 +6564,19 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 	}
 
 	if (pf->hw.phy.link_info.link_speed == I40E_LINK_SPEED_25GB) {
-		req_fec = ", Requested FEC: None";
-		fec = ", FEC: None";
-		an = ", Autoneg: False";
+		req_fec = "None";
+		fec = "None";
+		an = "False";
 
 		if (pf->hw.phy.link_info.an_info & I40E_AQ_AN_COMPLETED)
-			an = ", Autoneg: True";
+			an = "True";
 
 		if (pf->hw.phy.link_info.fec_info &
 		    I40E_AQ_CONFIG_FEC_KR_ENA)
-			fec = ", FEC: CL74 FC-FEC/BASE-R";
+			fec = "CL74 FC-FEC/BASE-R";
 		else if (pf->hw.phy.link_info.fec_info &
 			 I40E_AQ_CONFIG_FEC_RS_ENA)
-			fec = ", FEC: CL108 RS-FEC";
+			fec = "CL108 RS-FEC";
 
 		/* 'CL108 RS-FEC' should be displayed when RS is requested, or
 		 * both RS and FC are requested
@@ -6585,13 +6585,14 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 		    (I40E_AQ_REQUEST_FEC_KR | I40E_AQ_REQUEST_FEC_RS)) {
 			if (vsi->back->hw.phy.link_info.req_fec_info &
 			    I40E_AQ_REQUEST_FEC_RS)
-				req_fec = ", Requested FEC: CL108 RS-FEC";
+				req_fec = "CL108 RS-FEC";
 			else
-				req_fec = ", Requested FEC: CL74 FC-FEC/BASE-R";
+				req_fec = "CL74 FC-FEC/BASE-R";
 		}
 	}
 
-	netdev_info(vsi->netdev, "NIC Link is Up, %sbps Full Duplex%s%s%s, Flow Control: %s\n",
+	netdev_info(vsi->netdev,
+		    "NIC Link is Up, %sbps Full Duplex, Requested FEC: %s, Negotiated FEC: %s, Autoneg: %s, Flow Control: %s\n",
 		    speed, req_fec, fec, an, fc);
 }
 
-- 
2.21.0

