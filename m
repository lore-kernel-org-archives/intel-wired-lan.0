From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  2 Aug 2019 01:25:26 -0700
Subject: [Intel-wired-lan] [PATCH S26 08/15] ice: Fix resource leak in
 ice_remove_rule_internal()
In-Reply-To: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
Message-ID: <20190802082533.23083-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeb Cramer <jeb.j.cramer@intel.com>

We don't free s_rule if ice_aq_sw_rules() returns a non-zero status.  If
it returned a zero status, s_rule would be freed right after, so this
implies it should be freed within the scope of the function regardless.

Signed-off-by: Jeb Cramer <jeb.j.cramer@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 2e6ea062fa2a..c532fe06f5ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1623,12 +1623,13 @@ ice_remove_rule_internal(struct ice_hw *hw, u8 recp_id,
 		status = ice_aq_sw_rules(hw, s_rule,
 					 ICE_SW_RULE_RX_TX_NO_HDR_SIZE, 1,
 					 ice_aqc_opc_remove_sw_rules, NULL);
-		if (status)
-			goto exit;
 
 		/* Remove a book keeping from the list */
 		devm_kfree(ice_hw_to_dev(hw), s_rule);
 
+		if (status)
+			goto exit;
+
 		list_del(&list_elem->list_entry);
 		devm_kfree(ice_hw_to_dev(hw), list_elem);
 	}
-- 
2.20.1

