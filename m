From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 30 Oct 2018 00:41:28 +0900
Subject: [Intel-wired-lan] [PATCH 2/2] kconfig: remove silentoldconfig target
In-Reply-To: <1540827688-15999-1-git-send-email-yamada.masahiro@socionext.com>
References: <1540827688-15999-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1540827688-15999-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

As commit 911a91c39cab ("kconfig: rename silentoldconfig to
syncconfig") announced, it is time for the removal.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/networking/ice.rst | 2 +-
 scripts/kconfig/Makefile         | 9 +--------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/ice.rst b/Documentation/networking/ice.rst
index 1e4948c..4d118b8 100644
--- a/Documentation/networking/ice.rst
+++ b/Documentation/networking/ice.rst
@@ -20,7 +20,7 @@ Enabling the driver
 The driver is enabled via the standard kernel configuration system,
 using the make command::
 
-  make oldconfig/silentoldconfig/menuconfig/etc.
+  make oldconfig/menuconfig/etc.
 
 The driver is located in the menu structure at:
 
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 5d37a60..63b6092 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -68,14 +68,7 @@ PHONY += $(simple-targets)
 $(simple-targets): $(obj)/conf
 	$< $(silent) --$@ $(Kconfig)
 
-PHONY += silentoldconfig savedefconfig defconfig
-
-# We do not expect manual invokcation of "silentoldcofig" (or "syncconfig").
-silentoldconfig: syncconfig
-	@echo "  WARNING: \"silentoldconfig\" has been renamed to \"syncconfig\""
-	@echo "            and is now an internal implementation detail."
-	@echo "            What you want is probably \"oldconfig\"."
-	@echo "            \"silentoldconfig\" will be removed after Linux 4.19"
+PHONY += savedefconfig defconfig
 
 savedefconfig: $(obj)/conf
 	$< $(silent) --$@=defconfig $(Kconfig)
-- 
2.7.4

