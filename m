From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  2 Dec 2016 12:32:57 -0800
Subject: [Intel-wired-lan] [next PATCH S56 3/8] i40e: Save link FEC info
	from link up event
In-Reply-To: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
References: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480710782-9195-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Henry Tieman <henry.w.tieman@intel.com>

Store the FEC status bits from the link up event into the
hw_link_info structure.

Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
Change-ID: I9a7b256f6dfb0dce89c2f503075d0d383526832e
---
Testing Hints: In support of DCR 2228, this commit stores the FEC
data for later display in the "link up" kernel log message.

 drivers/net/ethernet/intel/i40e/i40e_common.c |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 21 +++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h |  1 +
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 59e766c..549fdca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1838,6 +1838,8 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
 	hw_link_info->link_speed = (enum i40e_aq_link_speed)resp->link_speed;
 	hw_link_info->link_info = resp->link_info;
 	hw_link_info->an_info = resp->an_info;
+	hw_link_info->fec_info = resp->config & (I40E_AQ_CONFIG_FEC_KR_ENA |
+						 I40E_AQ_CONFIG_FEC_RS_ENA);
 	hw_link_info->ext_info = resp->ext_info;
 	hw_link_info->loopback = resp->loopback;
 	hw_link_info->max_frame_size = le16_to_cpu(resp->max_frame_size);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a0689f1..951976b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5267,6 +5267,8 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 	enum i40e_aq_link_speed new_speed;
 	char *speed = "Unknown";
 	char *fc = "Unknown";
+	char *fec = "";
+	char *an = "";
 
 	new_speed = vsi->back->hw.phy.link_info.link_speed;
 
@@ -5326,8 +5328,23 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 		break;
 	}
 
-	netdev_info(vsi->netdev, "NIC Link is Up %sbps Full Duplex, Flow Control: %s\n",
-		    speed, fc);
+	if (vsi->back->hw.phy.link_info.link_speed == I40E_LINK_SPEED_25GB) {
+		fec = ", FEC: None";
+		an = ", Autoneg: False";
+
+		if (vsi->back->hw.phy.link_info.an_info & I40E_AQ_AN_COMPLETED)
+			an = ", Autoneg: True";
+
+		if (vsi->back->hw.phy.link_info.fec_info &
+		    I40E_AQ_CONFIG_FEC_KR_ENA)
+			fec = ", FEC: CL74 FC-FEC/BASE-R";
+		else if (vsi->back->hw.phy.link_info.fec_info &
+			 I40E_AQ_CONFIG_FEC_RS_ENA)
+			fec = ", FEC: CL108 RS-FEC";
+	}
+
+	netdev_info(vsi->netdev, "NIC Link is Up, %sbps Full Duplex%s%s, Flow Control: %s\n",
+		    speed, fec, an, fc);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index be7b611..df7914e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -184,6 +184,7 @@ struct i40e_link_status {
 	enum i40e_aq_link_speed link_speed;
 	u8 link_info;
 	u8 an_info;
+	u8 fec_info;
 	u8 ext_info;
 	u8 loopback;
 	/* is Link Status Event notification to SW enabled */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 3f19dff..16bb880 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -158,6 +158,7 @@ struct i40e_link_status {
 	enum i40e_aq_link_speed link_speed;
 	u8 link_info;
 	u8 an_info;
+	u8 fec_info;
 	u8 ext_info;
 	u8 loopback;
 	/* is Link Status Event notification to SW enabled */
-- 
2.4.11

