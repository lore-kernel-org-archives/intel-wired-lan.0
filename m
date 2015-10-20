From: Nicholas Krause <xerofoify@gmail.com>
Date: Tue, 20 Oct 2015 17:05:14 -0400
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the function
	fm10k_setup_tc
Message-ID: <1445375114-13378-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes error handling in the function fm10k_setup_tc to properly
check if the call to the function fm10k_open has failed by returning
a error and if so return immediately to the caller of the function
fm10k_setup_tc to properly signal this non recoverable failure.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 99228bf..5a4e702 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1146,6 +1146,7 @@ static struct rtnl_link_stats64 *fm10k_get_stats64(struct net_device *netdev,
 int fm10k_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
+	int err;
 
 	/* Currently only the PF supports priority classes */
 	if (tc && (interface->hw.mac.type != fm10k_mac_pf))
@@ -1175,7 +1176,9 @@ int fm10k_setup_tc(struct net_device *dev, u8 tc)
 	fm10k_mbx_request_irq(interface);
 
 	if (netif_running(dev))
-		fm10k_open(dev);
+		err = fm10k_open(dev);
+	if (err)
+		return err;
 
 	/* flag to indicate SWPRI has yet to be updated */
 	interface->flags |= FM10K_FLAG_SWPRI_CONFIG;
-- 
2.1.4

