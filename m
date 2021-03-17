From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Wed, 17 Mar 2021 15:30:01 +0530
Subject: [Intel-wired-lan] [PATCH] net: ethernet: intel: Fix a typo in the
 file ixgbe_dcb_nl.c
Message-ID: <20210317100001.2172893-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


s/Reprogam/Reprogram/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
index c00332d2e02a..72e6ebffea33 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
@@ -361,7 +361,7 @@ static u8 ixgbe_dcbnl_set_all(struct net_device *netdev)
 	}

 #ifdef IXGBE_FCOE
-	/* Reprogam FCoE hardware offloads when the traffic class
+	/* Reprogram FCoE hardware offloads when the traffic class
 	 * FCoE is using changes. This happens if the APP info
 	 * changes or the up2tc mapping is updated.
 	 */
--
2.30.2

