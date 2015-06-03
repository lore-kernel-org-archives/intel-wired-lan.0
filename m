From: Jia-Ju Bai <baijiaju1990@163.com>
Date: Wed,  3 Jun 2015 17:43:24 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Cleanup qos request in error
	handling of e1000_open
Message-ID: <1433324604-11369-1-git-send-email-baijiaju1990@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver lacks pm_qos_remove_request in error handling (err_req_irq)
of e1000_open, and qos request inserted by pm_qos_add_request is not removed.
This patch add pm_qos_remove_request in error handling to fix it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index c509a5c..f8c0dc4 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4451,6 +4451,7 @@ static int e1000_open(struct net_device *netdev)
 	return 0;
 
 err_req_irq:
+	pm_qos_remove_request(&adapter->pm_qos_req);
 	e1000e_release_hw_control(adapter);
 	e1000_power_down_phy(adapter);
 	e1000e_free_rx_resources(adapter->rx_ring);
-- 
1.7.9.5


