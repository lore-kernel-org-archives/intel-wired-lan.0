From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Wed, 2 Nov 2016 15:20:15 +0800
Subject: [Intel-wired-lan] [PATCH] igb/e1000: correct register comments
Message-ID: <1478071215-5122-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 drivers/net/ethernet/intel/igb/e1000_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_regs.h b/drivers/net/ethernet/intel/igb/e1000_regs.h
index d84afdd..58adbf2 100644
--- a/drivers/net/ethernet/intel/igb/e1000_regs.h
+++ b/drivers/net/ethernet/intel/igb/e1000_regs.h
@@ -320,7 +320,7 @@
 #define E1000_VT_CTL   0x0581C  /* VMDq Control - RW */
 #define E1000_WUC      0x05800  /* Wakeup Control - RW */
 #define E1000_WUFC     0x05808  /* Wakeup Filter Control - RW */
-#define E1000_WUS      0x05810  /* Wakeup Status - RO */
+#define E1000_WUS      0x05810  /* Wakeup Status - R/W1C */
 #define E1000_MANC     0x05820  /* Management Control - RW */
 #define E1000_IPAV     0x05838  /* IP Address Valid - RW */
 #define E1000_WUPL     0x05900  /* Wakeup Packet Length - RW */
-- 
2.1.0



