From: Janusz Wolak <januszwolak@awokados.com.pl>
Date: Tue, 13 Oct 2015 23:39:22 +0200
Subject: [Intel-wired-lan] [PATCH 6/6] e1000 driver remove checkpatch errors,
	warnings and checks.
In-Reply-To: <1444772362-25090-1-git-send-email-januszwolak@awokados.com.pl>
References: <1444772362-25090-1-git-send-email-januszwolak@awokados.com.pl>
Message-ID: <1444772362-25090-6-git-send-email-januszwolak@awokados.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Janusz Wolak <januszvdm@gmail.com>

Signed-off-by: Janusz Wolak <januszvdm@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_osdep.h | 49 +++++++++++++-------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_osdep.h b/drivers/net/ethernet/intel/e1000/e1000_osdep.h
index 33e7c45a..aeb3b95 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_osdep.h
+++ b/drivers/net/ethernet/intel/e1000/e1000_osdep.h
@@ -1,5 +1,5 @@
 /*******************************************************************************
-
+*
   Intel PRO/1000 Linux driver
   Copyright(c) 1999 - 2006 Intel Corporation.
 
@@ -26,7 +26,6 @@
 
 *******************************************************************************/
 
-
 /* glue for the OS independent part of e1000
  * includes register access macros
  */
@@ -34,7 +33,7 @@
 #ifndef _E1000_OSDEP_H_
 #define _E1000_OSDEP_H_
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 #define CONFIG_RAM_BASE         0x60000
 #define GBE_CONFIG_OFFSET       0x0
@@ -60,50 +59,50 @@
 					 ? E1000_##reg : E1000_82542_##reg))))
 
 #define E1000_WRITE_REG_ARRAY(a, reg, offset, value) ( \
-    writel((value), ((a)->hw_addr + \
-        (((a)->mac_type >= e1000_82543) ? E1000_##reg : E1000_82542_##reg) + \
-        ((offset) << 2))))
+			      writel((value), (@->hw_addr + \
+	(((a)->mac_type >= e1000_82543) ? E1000_##reg : E1000_82542_##reg) + \
+	((offset) << 2))))
 
 #define E1000_READ_REG_ARRAY(a, reg, offset) ( \
-    readl(@->hw_addr + \
-        (((a)->mac_type >= e1000_82543) ? E1000_##reg : E1000_82542_##reg) + \
-        ((offset) << 2)))
+			     readl(@->hw_addr + \
+	(((a)->mac_type >= e1000_82543) ? E1000_##reg : E1000_82542_##reg) + \
+	((offset) << 2)))
 
 #define E1000_READ_REG_ARRAY_DWORD E1000_READ_REG_ARRAY
 #define E1000_WRITE_REG_ARRAY_DWORD E1000_WRITE_REG_ARRAY
 
 #define E1000_WRITE_REG_ARRAY_WORD(a, reg, offset, value) ( \
-    writew((value), (@->hw_addr + \
-        (((a)->mac_type >= e1000_82543) ? E1000_##reg : E1000_82542_##reg) + \
-        ((offset) << 1))))
+				   writew((value), (@->hw_addr + \
+	(((a)->mac_type >= e1000_82543) ? E1000_##reg : E1000_82542_##reg) + \
+	((offset) << 1))))
 
 #define E1000_READ_REG_ARRAY_WORD(a, reg, offset) ( \
-    readw(@->hw_addr + \
-        (((a)->mac_type >= e1000_82543) ? E1000_##reg : E1000_82542_##reg) + \
-        ((offset) << 1)))
+				  readw(@->hw_addr + \
+	(((a)->mac_type >= e1000_82543) ? E1000_##reg : E1000_82542_##reg) + \
+	((offset) << 1)))
 
 #define E1000_WRITE_REG_ARRAY_BYTE(a, reg, offset, value) ( \
-    writeb((value), (@->hw_addr + \
-        (((a)->mac_type >= e1000_82543) ? E1000_##reg : E1000_82542_##reg) + \
-        (offset))))
+				   writeb((value), ((a)->hw_addr + \
+	(((a)->mac_type >= e1000_82543) ? E1000_##reg : E1000_82542_##reg) + \
+	(offset))))
 
 #define E1000_READ_REG_ARRAY_BYTE(a, reg, offset) ( \
-    readb((a)->hw_addr + \
-        (((a)->mac_type >= e1000_82543) ? E1000_##reg : E1000_82542_##reg) + \
-        (offset)))
+				  readb((a)->hw_addr + \
+	(((a)->mac_type >= e1000_82543) ? E1000_##reg : E1000_82542_##reg) + \
+	(offset)))
 
 #define E1000_WRITE_FLUSH() er32(STATUS)
 
 #define E1000_WRITE_ICH_FLASH_REG(a, reg, value) ( \
-    writel((value), ((a)->flash_address + reg)))
+				  writel((value), ((a)->flash_address + reg)))
 
 #define E1000_READ_ICH_FLASH_REG(a, reg) ( \
-    readl((a)->flash_address + reg))
+				 readl((a)->flash_address + reg))
 
 #define E1000_WRITE_ICH_FLASH_REG16(a, reg, value) ( \
-    writew((value), ((a)->flash_address + reg)))
+				    writew((value), ((a)->flash_address + reg)))
 
 #define E1000_READ_ICH_FLASH_REG16(a, reg) ( \
-    readw((a)->flash_address + reg))
+				   readw((a)->flash_address + reg))
 
 #endif /* _E1000_OSDEP_H_ */
-- 
1.9.1

