From: Nicholas Krause <xerofoify@gmail.com>
Date: Fri, 23 Oct 2015 15:14:36 -0400
Subject: [Intel-wired-lan] [PATCH] i40e:Fix variable assignment in the
	function i40e_set_ringparam
Message-ID: <1445627676-3977-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes variable assignment in the function i40e_set_ringparam
to properly assign the internal variable to the return value of
the call to the function i40e_up to properly allow us to signal
the caller when a error has occurred when trying to bring up
the device rather then assume incorrectly that it always succeeds
for this particular call in the function i40e_set_ringparm.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index e972b5e..13ef808 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1233,7 +1233,7 @@ static int i40e_set_ringparam(struct net_device *netdev,
 		rx_rings = NULL;
 	}
 
-	i40e_up(vsi);
+	err = i40e_up(vsi);
 
 free_tx:
 	/* error cleanup if the Rx allocations failed after getting Tx */
-- 
2.1.4

