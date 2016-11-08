From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  8 Nov 2016 13:05:11 -0800
Subject: [Intel-wired-lan] [next PATCH S52-V2 07/15] i40e/i40evf: replace
	for memcpy with single memcpy call in ethtool
In-Reply-To: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478639119-14656-8-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

memcpy replaced with single memcpy call in ethtool.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I3f5bef6bcc593412c56592c6459784db41575a0a
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9500e7b..76753e1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1536,10 +1536,8 @@ static void i40e_get_strings(struct net_device *netdev, u32 stringset,
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		for (i = 0; i < I40E_TEST_LEN; i++) {
-			memcpy(data, i40e_gstrings_test[i], ETH_GSTRING_LEN);
-			data += ETH_GSTRING_LEN;
-		}
+		memcpy(data, i40e_gstrings_test,
+		       I40E_TEST_LEN * ETH_GSTRING_LEN);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < I40E_NETDEV_STATS_LEN; i++) {
@@ -1623,18 +1621,12 @@ static void i40e_get_strings(struct net_device *netdev, u32 stringset,
 		/* BUG_ON(p - data != I40E_STATS_LEN * ETH_GSTRING_LEN); */
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++) {
-			memcpy(data, i40e_priv_flags_strings[i],
-			       ETH_GSTRING_LEN);
-			data += ETH_GSTRING_LEN;
-		}
-		if (pf->hw.pf_id == 0) {
-			for (i = 0; i < I40E_GL_PRIV_FLAGS_STR_LEN; i++) {
-				memcpy(data, i40e_gl_priv_flags_strings[i],
-				       ETH_GSTRING_LEN);
-				data += ETH_GSTRING_LEN;
-			}
-		}
+		memcpy(data, i40e_priv_flags_strings,
+		       I40E_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
+		data += I40E_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN;
+		if (pf->hw.pf_id == 0)
+			memcpy(data, i40e_gl_priv_flags_strings,
+			       I40E_GL_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
 		break;
 	default:
 		break;
-- 
2.4.11

