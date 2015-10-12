From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Sun, 11 Oct 2015 23:59:41 -0600
Subject: [Intel-wired-lan] [next-queue 1/8] igb: fix a typo in the
	configuration help menu
Message-ID: <1444629588-29933-1-git-send-email-sakiwit@gmail.com>
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
index 4163b16489b3..1268a182d1a2 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -124,7 +124,7 @@ config IGB_DCA
 	depends on IGB && DCA && !(IGB=y && DCA=m)
 	---help---
 	  Say Y here if you want to use Direct Cache Access (DCA) in the
-	  driver.  DCA is a method for warming the CPU cache before data
+	  driver.  DCA is a method for warning the CPU cache before data
 	  is used, with the intent of lessening the impact of cache misses.
 
 config IGBVF
