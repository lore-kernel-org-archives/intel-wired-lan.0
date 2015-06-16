From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 16 Jun 2015 13:39:11 -0700
Subject: [Intel-wired-lan] [PATCH rc2] fm10k: use an unsigned int for i in
	ethtool_get_strings
Message-ID: <1434487151-2735-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The value will never be negative, and we use the %u print format. Thus,
use unsigned int for the loop counter. Issue found using cppcheck.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 4b9d9f88af70..06f0b08d9af5 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -124,7 +124,7 @@ static void fm10k_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
 	char *p = (char *)data;
-	int i;
+	unsigned int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-- 
2.4.2

