From: Andre Guedes <andre.guedes@intel.com>
Date: Tue,  7 Jul 2020 16:47:57 -0700
Subject: [Intel-wired-lan] [PATCH ethtool 1/4] Add IGC driver support
In-Reply-To: <20200707234800.39119-1-andre.guedes@intel.com>
References: <20200707234800.39119-1-andre.guedes@intel.com>
Message-ID: <20200707234800.39119-2-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds the initial support for parsing registers dumped by the
IGC driver. At this moment, only the Receive Address Low (RAL) and the
Receive Address High (RAH) registers are parsed. More registers will be
added on demand.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 Makefile.am |  3 ++-
 ethtool.c   |  1 +
 igc.c       | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 internal.h  |  3 +++
 4 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 igc.c

diff --git a/Makefile.am b/Makefile.am
index a736237..2abb274 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -16,7 +16,8 @@ ethtool_SOURCES += \
 		  pcnet32.c realtek.c tg3.c marvell.c vioc.c	\
 		  smsc911x.c at76c50x-usb.c sfc.c stmmac.c	\
 		  sff-common.c sff-common.h sfpid.c sfpdiag.c	\
-		  ixgbevf.c tse.c vmxnet3.c qsfp.c qsfp.h fjes.c lan78xx.c
+		  ixgbevf.c tse.c vmxnet3.c qsfp.c qsfp.h fjes.c lan78xx.c \
+		  igc.c
 endif
 
 if ENABLE_BASH_COMPLETION
diff --git a/ethtool.c b/ethtool.c
index 021f528..07006b0 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -1049,6 +1049,7 @@ static const struct {
 	{ "lan78xx", lan78xx_dump_regs },
 	{ "dsa", dsa_dump_regs },
 	{ "fec", fec_dump_regs },
+	{ "igc", igc_dump_regs },
 #endif
 };
 
diff --git a/igc.c b/igc.c
new file mode 100644
index 0000000..91ab64d
--- /dev/null
+++ b/igc.c
@@ -0,0 +1,62 @@
+/* Copyright (c) 2020 Intel Corporation */
+#include <stdio.h>
+#include "internal.h"
+
+#define RAH_RAH					0x0000FFFF
+#define RAH_ASEL				0x00010000
+#define RAH_QSEL				0x000C0000
+#define RAH_QSEL_EN				0x10000000
+#define RAH_AV					0x80000000
+
+#define RAH_QSEL_SHIFT				18
+
+static const char *bit_to_boolean(u32 val)
+{
+	return val ? "True" : "False";
+}
+
+int igc_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs)
+{
+	u32 reg;
+	int offset, i;
+	u32 *regs_buff = (u32 *)regs->data;
+	u8 version = (u8)(regs->version >> 24);
+
+	if (version != 2)
+		return -1;
+
+	for (offset = 0; offset < 172; offset++) {
+		reg = regs_buff[offset];
+		printf("%04d: 0x%08X\n", offset, reg);
+	}
+
+	offset = 172;
+
+	for (i = 0; i < 16; i++) {
+		reg = regs_buff[offset + i];
+		printf("%04d: RAL (Receive Address Low %02d)               \n"
+		       "    Receive Address Low:                       %08X\n",
+		       offset + i, i,
+		       reg);
+	}
+
+	offset = 188;
+
+	for (i = 0; i < 16; i++) {
+		reg = regs_buff[offset + i];
+		printf("%04d: RAH (Receive Address High %02d)              \n"
+		       "    Receive Address High:                      %04X\n"
+		       "    Address Select:                            %s\n"
+		       "    Queue Select:                              %d\n"
+		       "    Queue Select Enable:                       %s\n"
+		       "    Address Valid:                             %s\n",
+		       offset + i, i,
+		       reg & RAH_RAH,
+		       reg & RAH_ASEL ? "Source" : "Destination",
+		       (reg & RAH_QSEL) >> RAH_QSEL_SHIFT,
+		       bit_to_boolean(reg & RAH_QSEL_EN),
+		       bit_to_boolean(reg & RAH_AV));
+	}
+
+	return 0;
+}
diff --git a/internal.h b/internal.h
index 45b63b7..1c6689a 100644
--- a/internal.h
+++ b/internal.h
@@ -393,4 +393,7 @@ int dsa_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
 /* i.MX Fast Ethernet Controller */
 int fec_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
 
+/* Intel(R) Ethernet Controller I225-LM/I225-V adapter family */
+int igc_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
+
 #endif /* ETHTOOL_INTERNAL_H__ */
-- 
2.26.2

