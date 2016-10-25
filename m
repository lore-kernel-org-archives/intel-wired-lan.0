From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 25 Oct 2016 15:17:59 -0700
Subject: [Intel-wired-lan] [next PATCH S51 5/9] i40e: avoid duplicate
	private flags definitions
In-Reply-To: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
References: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1477433883-3248-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Separate the global private flags and the regular private flags per
interface into two arrays. Future additions of private flags will not
need to be duplicated which may lead to buggy code. Also rename
"i40e_priv_flags_strings_gl" to "i40e_gl_priv_flags_strings" for
clarity, as it reads more naturally.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I68caef3c9954eb7da342d7f9d20f2873186f2758
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 42 +++++++++++---------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c8d5680..661ed11 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -228,26 +228,22 @@ static const char i40e_gstrings_test[][ETH_GSTRING_LEN] = {
 
 #define I40E_TEST_LEN (sizeof(i40e_gstrings_test) / ETH_GSTRING_LEN)
 
-static const char i40e_priv_flags_strings_gl[][ETH_GSTRING_LEN] = {
+static const char i40e_priv_flags_strings[][ETH_GSTRING_LEN] = {
 	"MFP",
 	"LinkPolling",
 	"flow-director-atr",
 	"veb-stats",
 	"hw-atr-eviction",
-	"vf-true-promisc-support",
 };
 
-#define I40E_PRIV_FLAGS_GL_STR_LEN ARRAY_SIZE(i40e_priv_flags_strings_gl)
+#define I40E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_priv_flags_strings)
 
-static const char i40e_priv_flags_strings[][ETH_GSTRING_LEN] = {
-	"NPAR",
-	"LinkPolling",
-	"flow-director-atr",
-	"veb-stats",
-	"hw-atr-eviction",
+/* Private flags with a global effect, restricted to PF 0 */
+static const char i40e_gl_priv_flags_strings[][ETH_GSTRING_LEN] = {
+	"vf-true-promisc-support",
 };
 
-#define I40E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_priv_flags_strings)
+#define I40E_GL_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_gl_priv_flags_strings)
 
 /**
  * i40e_partition_setting_complaint - generic complaint for MFP restriction
@@ -1198,10 +1194,9 @@ static void i40e_get_drvinfo(struct net_device *netdev,
 		sizeof(drvinfo->fw_version));
 	strlcpy(drvinfo->bus_info, pci_name(pf->pdev),
 		sizeof(drvinfo->bus_info));
+	drvinfo->n_priv_flags = I40E_PRIV_FLAGS_STR_LEN;
 	if (pf->hw.pf_id == 0)
-		drvinfo->n_priv_flags = I40E_PRIV_FLAGS_GL_STR_LEN;
-	else
-		drvinfo->n_priv_flags = I40E_PRIV_FLAGS_STR_LEN;
+		drvinfo->n_priv_flags += I40E_GL_PRIV_FLAGS_STR_LEN;
 }
 
 static void i40e_get_ringparam(struct net_device *netdev,
@@ -1429,10 +1424,8 @@ static int i40e_get_sset_count(struct net_device *netdev, int sset)
 			return I40E_VSI_STATS_LEN(netdev);
 		}
 	case ETH_SS_PRIV_FLAGS:
-		if (pf->hw.pf_id == 0)
-			return I40E_PRIV_FLAGS_GL_STR_LEN;
-		else
-			return I40E_PRIV_FLAGS_STR_LEN;
+		return I40E_PRIV_FLAGS_STR_LEN +
+			(pf->hw.pf_id == 0 ? I40E_GL_PRIV_FLAGS_STR_LEN : 0);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1630,15 +1623,14 @@ static void i40e_get_strings(struct net_device *netdev, u32 stringset,
 		/* BUG_ON(p - data != I40E_STATS_LEN * ETH_GSTRING_LEN); */
 		break;
 	case ETH_SS_PRIV_FLAGS:
+		for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++) {
+			memcpy(data, i40e_priv_flags_strings[i],
+			       ETH_GSTRING_LEN);
+			data += ETH_GSTRING_LEN;
+		}
 		if (pf->hw.pf_id == 0) {
-			for (i = 0; i < I40E_PRIV_FLAGS_GL_STR_LEN; i++) {
-				memcpy(data, i40e_priv_flags_strings_gl[i],
-				       ETH_GSTRING_LEN);
-				data += ETH_GSTRING_LEN;
-			}
-		} else {
-			for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++) {
-				memcpy(data, i40e_priv_flags_strings[i],
+			for (i = 0; i < I40E_GL_PRIV_FLAGS_STR_LEN; i++) {
+				memcpy(data, i40e_gl_priv_flags_strings[i],
 				       ETH_GSTRING_LEN);
 				data += ETH_GSTRING_LEN;
 			}
-- 
2.4.11

