From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Sun, 31 May 2015 21:25:25 +0300
Subject: [Intel-wired-lan] [PATCH 5/5] e1000e: Bump the version to 3.2.5
In-Reply-To: <ad0b0062af01fe16002d93a4a77faede268071eb.1433096643.git.yanirx.lubetkin@intel.com>
References: <ad0b0062af01fe16002d93a4a77faede268071eb.1433096643.git.yanirx.lubetkin@intel.com>
Message-ID: <edff339fa617e8eff908f6636eeaaa2862d5dcdf.1433096643.git.yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bump the version to reflect the driver changes and bug fixes for i219.
Also update the copyright, while we are at it.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/80003es2lan.c | 2 +-
 drivers/net/ethernet/intel/e1000e/80003es2lan.h | 2 +-
 drivers/net/ethernet/intel/e1000e/82571.c       | 2 +-
 drivers/net/ethernet/intel/e1000e/82571.h       | 2 +-
 drivers/net/ethernet/intel/e1000e/defines.h     | 2 +-
 drivers/net/ethernet/intel/e1000e/e1000.h       | 2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c     | 2 +-
 drivers/net/ethernet/intel/e1000e/hw.h          | 2 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c     | 2 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.h     | 2 +-
 drivers/net/ethernet/intel/e1000e/mac.c         | 2 +-
 drivers/net/ethernet/intel/e1000e/mac.h         | 2 +-
 drivers/net/ethernet/intel/e1000e/manage.c      | 2 +-
 drivers/net/ethernet/intel/e1000e/manage.h      | 2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c      | 6 +++---
 drivers/net/ethernet/intel/e1000e/nvm.c         | 2 +-
 drivers/net/ethernet/intel/e1000e/nvm.h         | 2 +-
 drivers/net/ethernet/intel/e1000e/param.c       | 2 +-
 drivers/net/ethernet/intel/e1000e/phy.c         | 2 +-
 drivers/net/ethernet/intel/e1000e/phy.h         | 2 +-
 drivers/net/ethernet/intel/e1000e/ptp.c         | 2 +-
 drivers/net/ethernet/intel/e1000e/regs.h        | 2 +-
 22 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.c b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
index 08f22f3..2af603f 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.c
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.h b/drivers/net/ethernet/intel/e1000e/80003es2lan.h
index 535a943..a2162e1 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.h
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.h
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/82571.c b/drivers/net/ethernet/intel/e1000e/82571.c
index 32e7775..5f70164 100644
--- a/drivers/net/ethernet/intel/e1000e/82571.c
+++ b/drivers/net/ethernet/intel/e1000e/82571.c
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/82571.h b/drivers/net/ethernet/intel/e1000e/82571.h
index 2e758f7..abc6a9a 100644
--- a/drivers/net/ethernet/intel/e1000e/82571.h
+++ b/drivers/net/ethernet/intel/e1000e/82571.h
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 0570c66..133d407 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 7d8a45c..0b748d1 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 9fe5f0f..6bd14e8 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index 19e8c48..c9da465 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index d9f7b93..b074b9a 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index a960d48..c0e3585 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index 30b74d5..e59d7c2 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/mac.h b/drivers/net/ethernet/intel/e1000e/mac.h
index 0513d90..8284618 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.h
+++ b/drivers/net/ethernet/intel/e1000e/mac.h
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/manage.c b/drivers/net/ethernet/intel/e1000e/manage.c
index 06edfca..cc9b3be 100644
--- a/drivers/net/ethernet/intel/e1000e/manage.c
+++ b/drivers/net/ethernet/intel/e1000e/manage.c
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/manage.h b/drivers/net/ethernet/intel/e1000e/manage.h
index a8c27f9..0b9ea59 100644
--- a/drivers/net/ethernet/intel/e1000e/manage.h
+++ b/drivers/net/ethernet/intel/e1000e/manage.h
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 674135c..805e267 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -48,7 +48,7 @@
 
 #define DRV_EXTRAVERSION "-k"
 
-#define DRV_VERSION "2.3.2" DRV_EXTRAVERSION
+#define DRV_VERSION "3.2.5" DRV_EXTRAVERSION
 char e1000e_driver_name[] = "e1000e";
 const char e1000e_driver_version[] = DRV_VERSION;
 
@@ -7439,7 +7439,7 @@ static int __init e1000_init_module(void)
 
 	pr_info("Intel(R) PRO/1000 Network Driver - %s\n",
 		e1000e_driver_version);
-	pr_info("Copyright(c) 1999 - 2014 Intel Corporation.\n");
+	pr_info("Copyright(c) 1999 - 2015 Intel Corporation.\n");
 	ret = pci_register_driver(&e1000_driver);
 
 	return ret;
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index fa6b103..49f205c 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.h b/drivers/net/ethernet/intel/e1000e/nvm.h
index 342bf69..5d46967 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.h
+++ b/drivers/net/ethernet/intel/e1000e/nvm.h
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/param.c b/drivers/net/ethernet/intel/e1000e/param.c
index aa1923f..6d8c39a 100644
--- a/drivers/net/ethernet/intel/e1000e/param.c
+++ b/drivers/net/ethernet/intel/e1000e/param.c
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index b2005e1..de13aea 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/phy.h b/drivers/net/ethernet/intel/e1000e/phy.h
index 537d278..55bfe47 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.h
+++ b/drivers/net/ethernet/intel/e1000e/phy.h
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index 8d7b21d..25a0ad5 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/drivers/net/ethernet/intel/e1000e/regs.h b/drivers/net/ethernet/intel/e1000e/regs.h
index 110e27e..b24e5fe 100644
--- a/drivers/net/ethernet/intel/e1000e/regs.h
+++ b/drivers/net/ethernet/intel/e1000e/regs.h
@@ -1,5 +1,5 @@
 /* Intel PRO/1000 Linux driver
- * Copyright(c) 1999 - 2014 Intel Corporation.
+ * Copyright(c) 1999 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

