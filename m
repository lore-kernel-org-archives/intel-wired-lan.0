From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Fri, 5 Mar 2021 03:46:42 -0600
Subject: [Intel-wired-lan] [PATCH RESEND][next] ixgbevf: Fix fall-through
 warnings for Clang
Message-ID: <20210305094642.GA141002@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of just letting the code
fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 449d7d5b280d..ba2ed8a43d2d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2633,6 +2633,7 @@ static void ixgbevf_set_num_queues(struct ixgbevf_adapter *adapter)
 			adapter->num_rx_queues = rss;
 			adapter->num_tx_queues = rss;
 			adapter->num_xdp_queues = adapter->xdp_prog ? rss : 0;
+			break;
 		default:
 			break;
 		}
-- 
2.27.0

