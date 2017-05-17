From: Benjamin Poirier <bpoirier@suse.com>
Date: Wed, 17 May 2017 16:24:13 -0400
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Don't return uninitialized
	stats
In-Reply-To: <20170425175433.ykc6ilm6uo7e6my2@f1.synalogic.ca>
References: <20170425175433.ykc6ilm6uo7e6my2@f1.synalogic.ca>
Message-ID: <20170517202413.18321-1-bpoirier@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Some statistics passed to ethtool are garbage because e1000e_get_stats64()
doesn't write them, for example: tx_heartbeat_errors. This leaks kernel
memory to userspace and confuses users.

Do like ixgbe and use dev_get_stats() which first zeroes out
rtnl_link_stats64.

Fixes: 5944701df90d ("net: remove useless memset's in drivers get_stats64")
Reported-by: Stefan Priebe <s.priebe@profihost.ag>
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---

Notes:
    Changes v1->v2:
    * add the Fixes tag

 drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index e23dbd9190d6..5b4d97570896 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -2072,7 +2072,7 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
 
 	pm_runtime_get_sync(netdev->dev.parent);
 
-	e1000e_get_stats64(netdev, &net_stats);
+	dev_get_stats(netdev, &net_stats);
 
 	pm_runtime_put_sync(netdev->dev.parent);
 
-- 
2.12.2

