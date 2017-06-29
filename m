From: Alice Michael <alice.michael@intel.com>
Date: Thu, 29 Jun 2017 04:36:36 -0400
Subject: [Intel-wired-lan] [next PATCH S75-V2 05/12] i40e: Store the
	requested FEC information
In-Reply-To: <20170629083643.82018-1-alice.michael@intel.com>
References: <20170629083643.82018-1-alice.michael@intel.com>
Message-ID: <20170629083643.82018-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

Store information about FEC modes, that were requested. It will be used
in printing link status information function and this way there is no
need to call admin queue there.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 4 ++++
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 8e082a9..5c36a18 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2529,6 +2529,10 @@ i40e_status i40e_update_link_info(struct i40e_hw *hw)
 		if (status)
 			return status;
 
+		hw->phy.link_info.req_fec_info =
+			abilities.fec_cfg_curr_mod_ext_info &
+			(I40E_AQ_REQUEST_FEC_KR | I40E_AQ_REQUEST_FEC_RS);
+
 		memcpy(hw->phy.link_info.module_type, &abilities.module_type,
 		       sizeof(hw->phy.link_info.module_type));
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 3a18ed1..fd4bbdd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -185,6 +185,7 @@ struct i40e_link_status {
 	enum i40e_aq_link_speed link_speed;
 	u8 link_info;
 	u8 an_info;
+	u8 req_fec_info;
 	u8 fec_info;
 	u8 ext_info;
 	u8 loopback;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index bde7f24..2ea919d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -159,6 +159,7 @@ struct i40e_link_status {
 	enum i40e_aq_link_speed link_speed;
 	u8 link_info;
 	u8 an_info;
+	u8 req_fec_info;
 	u8 fec_info;
 	u8 ext_info;
 	u8 loopback;
-- 
2.9.3

