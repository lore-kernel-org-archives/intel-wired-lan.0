From: Nicholas Krause <xerofoify@gmail.com>
Date: Fri,  9 Oct 2015 11:53:20 -0400
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the function
	fm10k_setup_tc for certain function calls
Message-ID: <1444406000-4446-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes the function fm10k_setup_tc to propley check if the
calls to either the function fm10k_init_queueing_scheme or the
function fm10k_mbx_request_irq fail by returning a error code to
signal that the call to either function has failed. Furthermore
if this arises exit immediately from the function fm10k_setup_tc
by returning the returned error code from the failed function call
to signal to the caller that setting up the tc on the device has
failed and the caller needs to handle this failed setup.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 99228bf..5e9087a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1146,6 +1146,7 @@ static struct rtnl_link_stats64 *fm10k_get_stats64(struct net_device *netdev,
 int fm10k_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
+	int err;
 
 	/* Currently only the PF supports priority classes */
 	if (tc && (interface->hw.mac.type != fm10k_mac_pf))
@@ -1170,9 +1171,13 @@ int fm10k_setup_tc(struct net_device *dev, u8 tc)
 	netdev_reset_tc(dev);
 	netdev_set_num_tc(dev, tc);
 
-	fm10k_init_queueing_scheme(interface);
+	err = fm10k_init_queueing_scheme(interface);
+	if (err)
+		return err;
 
-	fm10k_mbx_request_irq(interface);
+	err = fm10k_mbx_request_irq(interface);
+	if (err)
+		return err;
 
 	if (netif_running(dev))
 		fm10k_open(dev);
-- 
2.1.4

