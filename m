From: Nicholas Krause <xerofoify@gmail.com>
Date: Sat, 17 Oct 2015 12:48:34 -0400
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the function
	fm10k_setup_tc
Message-ID: <1445100514-26822-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes error handling in the function fm10k_setup_tc to
properly check if the calls to the functions fm10k_mbx_request
or fm10k_init_queueing_scheme fail by returning a error code and
if so return the error code returned by these functions immediately
to the call of fm10k_setup_tc to signal a failure has occurred when
called this particular function.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 99228bf..c5469af 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1146,7 +1146,8 @@ static struct rtnl_link_stats64 *fm10k_get_stats64(struct net_device *netdev,
 int fm10k_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
-
+	int err;
+
 	/* Currently only the PF supports priority classes */
 	if (tc && (interface->hw.mac.type != fm10k_mac_pf))
 		return -EINVAL;
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

