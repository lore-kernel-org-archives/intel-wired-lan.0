From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Fri, 20 Nov 2020 12:30:36 -0600
Subject: [Intel-wired-lan] [PATCH 039/141] ixgbevf: Fix fall-through
 warnings for Clang
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
Message-ID: <cec560b39c59d4c6b854fbe534cbe77050d097a8.1605896059.git.gustavoars@kernel.org>
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
index 82fce27f682b..afab78c51be0 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2639,6 +2639,7 @@ static void ixgbevf_set_num_queues(struct ixgbevf_adapter *adapter)
 			adapter->num_rx_queues = rss;
 			adapter->num_tx_queues = rss;
 			adapter->num_xdp_queues = adapter->xdp_prog ? rss : 0;
+			break;
 		default:
 			break;
 		}
-- 
2.27.0

