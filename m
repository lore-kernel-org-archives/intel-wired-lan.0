From: Colin King <colin.king@canonical.com>
Date: Fri,  6 Sep 2019 12:33:56 +0100
Subject: [Intel-wired-lan] [PATCH] net/ixgbevf: make array api static const,
 makes object smaller
Message-ID: <20190906113356.9985-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array api on the stack but instead make it
static const. Makes the object code smaller by 58 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  82969	   9763	    256	  92988	  16b3c	ixgbevf/ixgbevf_main.o

After:
   text	   data	    bss	    dec	    hex	filename
  82815	   9859	    256	  92930	  16b02	ixgbevf/ixgbevf_main.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 8c011d4ce7a9..46c8e2501084 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2261,12 +2261,14 @@ static void ixgbevf_init_last_counter_stats(struct ixgbevf_adapter *adapter)
 static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	int api[] = { ixgbe_mbox_api_14,
-		      ixgbe_mbox_api_13,
-		      ixgbe_mbox_api_12,
-		      ixgbe_mbox_api_11,
-		      ixgbe_mbox_api_10,
-		      ixgbe_mbox_api_unknown };
+	static const int api[] = {
+		ixgbe_mbox_api_14,
+		ixgbe_mbox_api_13,
+		ixgbe_mbox_api_12,
+		ixgbe_mbox_api_11,
+		ixgbe_mbox_api_10,
+		ixgbe_mbox_api_unknown
+	};
 	int err, idx = 0;
 
 	spin_lock_bh(&adapter->mbx_lock);
-- 
2.20.1

