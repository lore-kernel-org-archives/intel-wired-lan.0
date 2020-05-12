From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 12 May 2020 10:35:52 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] igc: Reject NFC rules with multiple
 matches
Message-ID: <20200512173553.39460-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The way rx queue assignment based on mac address, ethetype and vlan
priority filtering operates in I225 doesn't allow us to properly support
NFC rules with multiple matches.

Consider the following example which assigns to queue 2 frames matching
the address MACADDR *and* ethertype ETYPE.

$ ethtool -N eth0 flow-type ether dst <MACADDR> proto <ETYPE> queue 2

When such rule is applied, we have 2 unwanted behaviors:

    1) Any frame matching MACADDR will be assigned to queue 2. It
       doesn't matter the ETYPE value.

    2) Any accepted frame that has ethertype equals to ETYPE, no matter
       the mac address, will be assigned to queue 2 as well.

In current code, multiple-match filters are accepted by the driver, even
though it doesn't support them properly. This patch adds a check for
multiple-match rules in igc_ethtool_is_nfc_rule_valid() so they are
rejected.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 247d0f5c4eb8..2214a5d3a259 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1222,8 +1222,8 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
  * @adapter: Pointer to adapter.
  * @rule: Rule under evaluation.
  *
- * Rules with both destination and source MAC addresses are considered invalid
- * since the driver doesn't support them.
+ * The driver doesn't support rules with multiple matches so if more than
+ * one bit in filter flags is set, @rule is considered invalid.
  *
  * Also, if there is already another rule with the same filter in a different
  * location, @rule is considered invalid.
@@ -1244,9 +1244,8 @@ static int igc_ethtool_check_nfc_rule(struct igc_adapter *adapter,
 		return -EINVAL;
 	}
 
-	if (flags & IGC_FILTER_FLAG_DST_MAC_ADDR &&
-	    flags & IGC_FILTER_FLAG_SRC_MAC_ADDR) {
-		netdev_dbg(dev, "Filters with both dst and src are not supported");
+	if (flags & (flags - 1)) {
+		netdev_dbg(dev, "Rule with multiple matches not supported");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.26.2

