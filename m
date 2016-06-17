From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 17 Jun 2016 14:36:45 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: remove fm10k_get_reta_size from
	namespace
Message-ID: <20160617213645.11660-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The function is only used in fm10k_ethtool.c, so make it static.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h         | 1 -
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 75429f2bbc97..e9850697be04 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -496,7 +496,6 @@ int fm10k_close(struct net_device *netdev);
 
 /* Ethtool */
 void fm10k_set_ethtool_ops(struct net_device *dev);
-u32 fm10k_get_reta_size(struct net_device *netdev);
 void fm10k_write_reta(struct fm10k_intfc *interface, const u32 *indir);
 
 /* IOV */
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index c04cbe9c9f7c..adb7cb4311ba 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -966,7 +966,7 @@ static int fm10k_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 	return 0;
 }
 
-u32 fm10k_get_reta_size(struct net_device __always_unused *netdev)
+static u32 fm10k_get_reta_size(struct net_device __always_unused *netdev)
 {
 	return FM10K_RETA_SIZE * FM10K_RETA_ENTRIES_PER_REG;
 }
-- 
2.9.0.rc1.405.g81f467e

