From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  3 Sep 2015 17:18:58 -0400
Subject: [Intel-wired-lan] [next PATCH S15 11/15] i40e: Store off PHY
	capabilities
In-Reply-To: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441315142-173025-12-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kevin Scott <kevin.c.scott@intel.com>

Store off reported PHY capabilities in link_info structure.

Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
Change-ID: Ife0f037c26983ca985dbf79abf33f8f8791369e8
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index c1d0dca..26bb922 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1617,6 +1617,9 @@ i40e_status i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
 	if (hw->aq.asq_last_status == I40E_AQ_RC_EIO)
 		status = I40E_ERR_UNKNOWN_PHY;
 
+	if (report_init)
+		hw->phy.phy_types = le32_to_cpu(abilities->phy_type);
+
 	return status;
 }
 
-- 
1.9.3

