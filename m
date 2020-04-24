From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 24 Apr 2020 13:16:20 -0700
Subject: [Intel-wired-lan] [PATCH 16/19] igc: Fix NFC rule validation
In-Reply-To: <20200424201623.10971-1-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
Message-ID: <20200424201623.10971-17-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If we try to overwrite an existing rule with the same filter but
different action, we get EEXIST error as shown below.

$ ethtool -N eth0 flow-type ether dst <MACADDR> action 1 loc 10
$ ethtool -N eth0 flow-type ether dst <MACADDR> action 2 loc 10
rmgr: Cannot insert RX class rule: File exists

The second command is expected to overwrite the previous rule in location
10 and succeed.

This patch fixes igc_ethtool_check_nfc_rule() so it also checks the
rules location. In case they match, the rule under evaluation should not
be considered invalid.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index de9ab3c8179a..32bc77af71dd 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1225,8 +1225,8 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
  * Rules with both destination and source MAC addresses are considered invalid
  * since the driver doesn't support them.
  *
- * Also, if there is already another rule with the same filter, @rule is
- * considered invalid.
+ * Also, if there is already another rule with the same filter in a different
+ * location, @rule is considered invalid.
  *
  * Context: Expects adapter->nfc_rule_lock to be held by caller.
  *
@@ -1252,7 +1252,8 @@ static int igc_ethtool_check_nfc_rule(struct igc_adapter *adapter,
 
 	list_for_each_entry(tmp, &adapter->nfc_rule_list, list) {
 		if (!memcmp(&rule->filter, &tmp->filter,
-			    sizeof(rule->filter))) {
+			    sizeof(rule->filter)) &&
+		    tmp->location != rule->location) {
 			netdev_dbg(dev, "Rule already exists");
 			return -EEXIST;
 		}
-- 
2.26.0

