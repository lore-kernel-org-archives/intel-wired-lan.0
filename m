From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Mon, 12 Oct 2015 15:38:24 +0000
Subject: [Intel-wired-lan] [next-queue 2/8] ixgbe: fix a typo in
	the	configuration help menu
In-Reply-To: <1444629588-29933-2-git-send-email-sakiwit@gmail.com>
References: <1444629588-29933-1-git-send-email-sakiwit@gmail.com>
 <1444629588-29933-2-git-send-email-sakiwit@gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD65366DA25@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

NAK, warming is correct.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jean Sacren
Sent: Sunday, October 11, 2015 11:00 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next-queue 2/8] ixgbe: fix a typo in the configuration help menu

From: Jean Sacren <sakiwit@gmail.com>

'warming' should be 'warning'. Fix it so that the pertinent text in Direct Cache Access (DCA) Support menu would deliver the intended semantics.

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
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
