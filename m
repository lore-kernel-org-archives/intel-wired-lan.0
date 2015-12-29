From: Insu Yun <wuninsu@gmail.com>
Date: Tue, 29 Dec 2015 16:55:17 -0500
Subject: [Intel-wired-lan] [PATCH] ixgbe: correctly handling failed
	allocation
Message-ID: <1451426117-30986-1-git-send-email-wuninsu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since kzalloc can be failed in memory pressure,
NULL derefence could be happened.

Signed-off-by: Insu Yun <wuninsu@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index aed8d02..aa5eda0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5331,6 +5331,8 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
 	adapter->mac_table = kzalloc(sizeof(struct ixgbe_mac_addr) *
 				     hw->mac.num_rar_entries,
 				     GFP_ATOMIC);
+	if (!adapter->mac_table)
+		return -ENOMEM;
 
 	/* Set MAC specific capability flags and exceptions */
 	switch (hw->mac.type) {
-- 
1.9.1

