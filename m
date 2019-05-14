From: Alice Michael <alice.michael@intel.com>
Date: Tue, 14 May 2019 10:37:01 -0700
Subject: [Intel-wired-lan] [next PATCH S5 iavf 03/11] iavf: wait longer for
 close to complete
In-Reply-To: <20190514173709.62431-1-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
Message-ID: <20190514173709.62431-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

On some hardware/driver/architecture combinations, it may take longer
than 200msec for all close operations to be completed, causing a
spurious error message to be logged.

Increase the timeout value to 500msec to avoid this erroneous error.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 36f17d0c7a2e..9ce04a8c0d0f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3021,7 +3021,7 @@ static int iavf_close(struct net_device *netdev)
 
 	status = wait_event_timeout(adapter->down_waitqueue,
 				    adapter->state == __IAVF_DOWN,
-				    msecs_to_jiffies(200));
+				    msecs_to_jiffies(500));
 	if (!status)
 		netdev_warn(netdev, "Device resources not yet released\n");
 	return 0;
-- 
2.19.2

