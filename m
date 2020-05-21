From: Chen Yu <yu.c.chen@intel.com>
Date: Fri, 22 May 2020 01:59:13 +0800
Subject: [Intel-wired-lan] [PATCH 2/2] e1000e: Make WOL info in ethtool
 consistent with device wake up ability
In-Reply-To: <cover.1590081982.git.yu.c.chen@intel.com>
References: <cover.1590081982.git.yu.c.chen@intel.com>
Message-ID: <725bad2f3ce7f7b7f1667d53b6527dc059f9e419.1590081982.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently the ethtool shows that WOL(Wake On Lan) is enabled
even if the device wakeup ability has been disabled via sysfs:
  cat /sys/devices/pci0000:00/0000:00:1f.6/power/wakeup
   disabled

  ethtool eno1
  ...
  Wake-on: g

Fix this in ethtool to check if the user has explicitly disabled the
wake up ability for this device.

Fixes: 6ff68026f475 ("e1000e: Use device_set_wakeup_enable")
Reported-by: Len Brown <len.brown@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 1d47e2503072..0cccd823ff24 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -1891,7 +1891,7 @@ static void e1000_get_wol(struct net_device *netdev,
 	wol->wolopts = 0;
 
 	if (!(adapter->flags & FLAG_HAS_WOL) ||
-	    !device_can_wakeup(&adapter->pdev->dev))
+	    !device_may_wakeup(&adapter->pdev->dev))
 		return;
 
 	wol->supported = WAKE_UCAST | WAKE_MCAST |
-- 
2.17.1

