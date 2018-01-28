From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Sun, 28 Jan 2018 03:53:37 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Avoid to write the RETA table when
 unnecessary.
Message-ID: <1517140417-26439-1-git-send-email-xiangxia.m.yue@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If indir == 0 in the ixgbe_set_rxfh(), it is unnecessary
to write the HW. Because redirection table is not changed.

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 3173510..8c652c6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3059,6 +3059,8 @@ static int ixgbe_set_rxfh(struct net_device *netdev, const u32 *indir,
 
 		for (i = 0; i < reta_entries; i++)
 			adapter->rss_indir_tbl[i] = indir[i];
+
+		ixgbe_store_reta(adapter);
 	}
 
 	/* Fill out the rss hash key */
@@ -3067,8 +3069,6 @@ static int ixgbe_set_rxfh(struct net_device *netdev, const u32 *indir,
 		ixgbe_store_key(adapter);
 	}
 
-	ixgbe_store_reta(adapter);
-
 	return 0;
 }
 
-- 
1.8.3.1

