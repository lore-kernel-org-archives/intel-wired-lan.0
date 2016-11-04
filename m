From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  4 Nov 2016 10:36:07 -0700
Subject: [Intel-wired-lan] [next PATCH S52 10/11] i40e: Preserve extended
	PHY type field in i40e_set_fc()
In-Reply-To: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
References: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478280968-8098-11-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Eric Joyner <eric.joyner@intel.com>

Prevents 25G PHY types from being disabled when setting the
flow control modes.

Signed-off-by: Eric Joyner <eric.joyner@intel.com>
Change-ID: Ib600c7d6389390ed5395154bd954ea4882e7654a
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 5ef7387..91d7550 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1705,6 +1705,7 @@ enum i40e_status_code i40e_set_fc(struct i40e_hw *hw, u8 *aq_failures,
 			config.abilities |= I40E_AQ_PHY_ENABLE_ATOMIC_LINK;
 		/* Copy over all the old settings */
 		config.phy_type = abilities.phy_type;
+		config.phy_type_ext = abilities.phy_type_ext;
 		config.link_speed = abilities.link_speed;
 		config.eee_capability = abilities.eee_capability;
 		config.eeer = abilities.eeer_val;
-- 
2.4.11

