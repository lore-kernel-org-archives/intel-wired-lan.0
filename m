From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  1 Mar 2018 00:17:36 +0100
Subject: [Intel-wired-lan] [net-next PATCH] ixgbevf: fix unused variable
 warning
Message-ID: <20180228231745.366681-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The new ixgbevf_set_rx_buffer_len() function causes a harmless warnings
in configurations with large page size:

drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function 'ixgbevf_set_rx_buffer_len':
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:1758:15: error: unused variable 'max_frame' [-Werror=unused-variable]

This rephrases the code so that the compiler can see the use of that
variable, making it slightly easier to read in the process.

Fixes: f15c5ba5b6cd ("ixgbevf: add support for using order 1 pages to receive large frames")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index f37307131eb6..4da449e0a4ba 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1766,12 +1766,12 @@ static void ixgbevf_set_rx_buffer_len(struct ixgbevf_adapter *adapter,
 
 	set_ring_build_skb_enabled(rx_ring);
 
-#if (PAGE_SIZE < 8192)
-	if (max_frame <= IXGBEVF_MAX_FRAME_BUILD_SKB)
-		return;
+	if (PAGE_SIZE < 8192) {
+		if (max_frame <= IXGBEVF_MAX_FRAME_BUILD_SKB)
+			return;
 
-	set_ring_uses_large_buffer(rx_ring);
-#endif
+		set_ring_uses_large_buffer(rx_ring);
+	}
 }
 
 /**
-- 
2.9.0

