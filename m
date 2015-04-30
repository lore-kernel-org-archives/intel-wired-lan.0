From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2015 16:09:41 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: fix LINUX_VERSION's use of
	EXTRA_CFLAGS
Message-ID: <1430435381-6028-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In order not to override any CFLAGS_EXTRA from the command line, we
create an extra variable EXTRA_CFLAGS which contains our introductino of
LINUX_VERSION_CODE, and append CFLAGS_EXTRA to this. However, the i40e
driver never did this previously, so it passed CFLAGS_EXTRA directly
into the kernel build rule. This patch fixes the issue by using
EXTRA_CFLAGS in its place. Without LINUX_VERSION, EXTRA_CFLAGS is
equivalent to CFLAGS_EXTRA.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-type: Build Change
Complexity: Low
Customer-visible: No
---
 src/Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index aee4f91ad4c2..9bb0d4f66bb8 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -195,9 +195,9 @@ endif
 # $2 is the kernel build target
 kernelbuild = $(shell (\
 		if [ -n "$(KOBJ)" ]; then \
-			$(MAKE) ccflags-y:="$(CFLAGS_EXTRA)" -C $(KSRC) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=$(realpath $(1)) INSTALL_MOD_PATH=$(INSTALL_MOD_PATH) $(2) ; \
+			$(MAKE) ccflags-y:="$(EXTRA_CFLAGS)" -C $(KSRC) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=$(realpath $(1)) INSTALL_MOD_PATH=$(INSTALL_MOD_PATH) $(2) ; \
 		else \
-			$(MAKE) ccflags-y:="$(CFLAGS_EXTRA)" -C $(KSRC) -O $(KOBJ) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=$(realpath $(1)) INSTALL_MOD_PATH=$(INSTALL_MOD_PATH) $(2) ; \
+			$(MAKE) ccflags-y:="$(EXTRA_CFLAGS)" -C $(KSRC) -O $(KOBJ) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=$(realpath $(1)) INSTALL_MOD_PATH=$(INSTALL_MOD_PATH) $(2) ; \
 		fi > .tmp ; rm .tmp))
 
 
@@ -213,9 +213,9 @@ $(MODULES): $(TARGETS)
 $(TARGETS): $(SOURCES)
 	@for s in $(DRIVERS) ; do \
 		if [ -n "$(KOBJ)" ]; then \
-			$(MAKE) ccflags-y+="$(CFLAGS_EXTRA)" -C $(KSRC) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=`pwd`/$$s modules ; \
+			$(MAKE) ccflags-y+="$(EXTRA_CFLAGS)" -C $(KSRC) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=`pwd`/$$s modules ; \
 		else \
-			$(MAKE) ccflags-y+="$(CFLAGS_EXTRA)" -C $(KSRC) -O $(KOBJ) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=`pwd`/$$s modules ; \
+			$(MAKE) ccflags-y+="$(EXTRA_CFLAGS)" -C $(KSRC) -O $(KOBJ) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=`pwd`/$$s modules ; \
 		fi ; \
 	done
 
@@ -236,18 +236,18 @@ silent: $(SOURCES)
 sparse: clean $(SOURCES)
 	@for s in $(DRIVERS) ; do \
 		if [ -n "$(KOBJ)" ]; then \
-			$(MAKE) ccflags-y+="$(CFLAGS_EXTRA)" -C $(KSRC) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=`pwd`/$$s C=2 CF="-D__CHECK_ENDIAN__ -Wbitwise -Wcontext" modules ; \
+			$(MAKE) ccflags-y+="$(EXTRA_CFLAGS)" -C $(KSRC) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=`pwd`/$$s C=2 CF="-D__CHECK_ENDIAN__ -Wbitwise -Wcontext" modules ; \
 		else \
-			$(MAKE) ccflags-y+="$(CFLAGS_EXTRA)" -C $(KSRC) -O $(KOBJ) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=`pwd`/$$s C=2 CF="-D__CHECK_ENDIAN_ -Wbitwise -Wcontext" modules ; \
+			$(MAKE) ccflags-y+="$(EXTRA_CFLAGS)" -C $(KSRC) -O $(KOBJ) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=`pwd`/$$s C=2 CF="-D__CHECK_ENDIAN_ -Wbitwise -Wcontext" modules ; \
 		fi ; \
 	done
 
 ccc: clean $(SOURCES)
 	@for s in $(DRIVERS) ; do \
 		if [ -n "$(KOBJ)" ]; then \
-			$(MAKE) ccflags-y+="$(CFLAGS_EXTRA)" -C $(KSRC) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=`pwd`/$$s coccicheck MODE=report; \
+			$(MAKE) ccflags-y+="$(EXTRA_CFLAGS)" -C $(KSRC) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=`pwd`/$$s coccicheck MODE=report; \
 		else \
-			$(MAKE) ccflags-y+="$(CFLAGS_EXTRA)" -C $(KSRC) -O $(KOBJ) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=`pwd`/$$s coccicheck MODE=report; \
+			$(MAKE) ccflags-y+="$(EXTRA_CFLAGS)" -C $(KSRC) -O $(KOBJ) CONFIG_I40E=m CONFIG_I40EVF=m SUBDIRS=`pwd`/$$s coccicheck MODE=report; \
 		fi ; \
 	done
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-i40e-fix-LINUX_VERSION-s-use-of-EXTRA_CFLAGS.patch
Type: text/x-patch
Size: 3884 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150430/b2b78f01/attachment.bin>
