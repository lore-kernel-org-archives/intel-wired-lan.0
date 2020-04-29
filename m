From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 29 Apr 2020 14:43:06 -0700
Subject: [Intel-wired-lan] [RFC PATCH] igc: Reject NFC rules with multiple
 matches
Message-ID: <20200429214306.71046-1-andre.guedes@intel.com>
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

While we could fix 1) by not enabling queue assignment on the MAC
address filter, 2) would still happen.

In current code, multiple-match filters are accepted by the driver, even
though it doesn't support them properly. This patch adds a check for
multiple-match rules in igc_ethtool_is_nfc_rule_valid() so they are
rejected.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
Hi folks,

This patch was originally included in the series "igc: Fixes to NFC support
code", but since it changes the way the driver interacts with user space, I
decided to sent it separately as RFC to collect your opinions.

The patch description gives a detailed explanation about the issue. The bottom
line is: Current code silently accepts a configuration that is not supported.
This patch changes the driver so EOPNOTSUPP is returned instead of success.

What I'd like to get your feedback on is:

Is this considered an user-kernel break? If so, what would be the best way to
move forward. Keep accepting the configuration but warn user via log message
about not supporting it?

Thank you,

Andre
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index db42dc046403..8fd027d970ca 100644
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
2.26.0

