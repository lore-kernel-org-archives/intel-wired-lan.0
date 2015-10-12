From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Sun, 11 Oct 2015 23:59:42 -0600
Subject: [Intel-wired-lan] [next-queue 2/8] ixgbe: fix a typo in the
	configuration help menu
In-Reply-To: <1444629588-29933-1-git-send-email-sakiwit@gmail.com>
References: <1444629588-29933-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1444629588-29933-2-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

'warming' should be 'warning'. Fix it so that the pertinent text in
Direct Cache Access (DCA) Support menu would deliver the intended
semantics.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
 drivers/net/ethernet/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 1268a182d1a2..de699cd628f4 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -215,7 +215,7 @@ config IXGBE_DCA
 	depends on IXGBE && DCA && !(IXGBE=y && DCA=m)
 	---help---
 	  Say Y here if you want to use Direct Cache Access (DCA) in the
-	  driver.  DCA is a method for warming the CPU cache before data
+	  driver.  DCA is a method for warning the CPU cache before data
 	  is used, with the intent of lessening the impact of cache misses.
 
 config IXGBE_DCB
