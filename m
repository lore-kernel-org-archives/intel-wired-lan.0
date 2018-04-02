From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Mon,  2 Apr 2018 09:26:06 -0700
Subject: [Intel-wired-lan] [PATCH] ice: Bug fixes in ethtool code
Message-ID: <20180402162606.16234-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

1) Return correct size from ice_get_regs_len.
2) Fix incorrect use of ARRAY_SIZE in ice_get_regs.

Fixes: fcea6f3da546 (ice: Add stats and ethtool support)
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 186764a5c263..1db304c01d10 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -156,7 +156,7 @@ ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 
 static int ice_get_regs_len(struct net_device __always_unused *netdev)
 {
-	return ARRAY_SIZE(ice_regs_dump_list);
+	return sizeof(ice_regs_dump_list);
 }
 
 static void
@@ -170,7 +170,7 @@ ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
 
 	regs->version = 1;
 
-	for (i = 0; i < ARRAY_SIZE(ice_regs_dump_list) / sizeof(u32); ++i)
+	for (i = 0; i < ARRAY_SIZE(ice_regs_dump_list); ++i)
 		regs_buf[i] = rd32(hw, ice_regs_dump_list[i]);
 }
 
-- 
2.14.3

