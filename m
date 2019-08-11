From: Wenwen Wang <wenwen@cs.uga.edu>
Date: Sun, 11 Aug 2019 15:07:47 -0500
Subject: [Intel-wired-lan] [PATCH] net: ixgbe: fix memory leaks
Message-ID: <1565554067-4994-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In ixgbe_configure_clsu32(), 'jump', 'input', and 'mask' are allocated
through kzalloc() respectively in a for loop body. Then,
ixgbe_clsu32_build_input() is invoked to build the input. If this process
fails, next iteration of the for loop will be executed. However, the
allocated 'jump', 'input', and 'mask' are not deallocated on this execution
path, leading to memory leaks.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index cbaf712..6b7ea87 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9490,6 +9490,10 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 				jump->mat = nexthdr[i].jump;
 				adapter->jump_tables[link_uhtid] = jump;
 				break;
+			} else {
+				kfree(mask);
+				kfree(input);
+				kfree(jump);
 			}
 		}
 		return 0;
-- 
2.7.4

