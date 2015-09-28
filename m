From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:34 -0400
Subject: [Intel-wired-lan] [next PATCH S16 05/15] i40e: priv flag for
	controlling VEB stats
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-6-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Add an ethtool priv flag to enable and disable printing
the VEB statistics.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I7654054a3a73b08aa8310d94ee8fce6219107dd8
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index cb8002f..446d6a8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -103,6 +103,7 @@
 #define I40E_PRIV_FLAGS_NPAR_FLAG	BIT(0)
 #define I40E_PRIV_FLAGS_LINKPOLL_FLAG	BIT(1)
 #define I40E_PRIV_FLAGS_FD_ATR		BIT(2)
+#define I40E_PRIV_FLAGS_VEB_STATS	BIT(3)
 
 #define I40E_NVM_VERSION_LO_SHIFT  0
 #define I40E_NVM_VERSION_LO_MASK   (0xff << I40E_NVM_VERSION_LO_SHIFT)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0ea71c0..21612d9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -229,6 +229,7 @@ static const char i40e_priv_flags_strings[][ETH_GSTRING_LEN] = {
 	"NPAR",
 	"LinkPolling",
 	"flow-director-atr",
+	"veb-stats",
 };
 
 #define I40E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_priv_flags_strings)
@@ -2671,6 +2672,8 @@ static u32 i40e_get_priv_flags(struct net_device *dev)
 		I40E_PRIV_FLAGS_LINKPOLL_FLAG : 0;
 	ret_flags |= pf->flags & I40E_FLAG_FD_ATR_ENABLED ?
 		I40E_PRIV_FLAGS_FD_ATR : 0;
+	ret_flags |= pf->flags & I40E_FLAG_VEB_STATS_ENABLED ?
+		I40E_PRIV_FLAGS_VEB_STATS : 0;
 
 	return ret_flags;
 }
@@ -2702,6 +2705,11 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 		pf->auto_disable_flags |= I40E_FLAG_FD_ATR_ENABLED;
 	}
 
+	if (flags & I40E_PRIV_FLAGS_VEB_STATS)
+		pf->flags |= I40E_FLAG_VEB_STATS_ENABLED;
+	else
+		pf->flags &= ~I40E_FLAG_VEB_STATS_ENABLED;
+
 	return 0;
 }
 
-- 
1.9.3

