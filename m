From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon,  4 Dec 2017 21:35:08 -0800
Subject: [Intel-wired-lan] [next-queue 02/10] ixgbe: add ipsec register
 access routines
In-Reply-To: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1512452116-14795-3-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a few routines to make access to the ipsec registers just a little
easier, and throw in the beginnings of an initialization.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/Makefile      |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h       |   6 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 157 +++++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h |  50 ++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   1 +
 5 files changed, 215 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h

diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile b/drivers/net/ethernet/intel/ixgbe/Makefile
index 35e6fa6..8319465 100644
--- a/drivers/net/ethernet/intel/ixgbe/Makefile
+++ b/drivers/net/ethernet/intel/ixgbe/Makefile
@@ -42,3 +42,4 @@ ixgbe-$(CONFIG_IXGBE_DCB) +=  ixgbe_dcb.o ixgbe_dcb_82598.o \
 ixgbe-$(CONFIG_IXGBE_HWMON) += ixgbe_sysfs.o
 ixgbe-$(CONFIG_DEBUG_FS) += ixgbe_debugfs.o
 ixgbe-$(CONFIG_FCOE:m=y) += ixgbe_fcoe.o
+ixgbe-$(CONFIG_XFRM_OFFLOAD) += ixgbe_ipsec.o
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index dd55787..1e11462 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -52,6 +52,7 @@
 #ifdef CONFIG_IXGBE_DCA
 #include <linux/dca.h>
 #endif
+#include "ixgbe_ipsec.h"
 
 #include <net/busy_poll.h>
 
@@ -1001,4 +1002,9 @@ void ixgbe_store_key(struct ixgbe_adapter *adapter);
 void ixgbe_store_reta(struct ixgbe_adapter *adapter);
 s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 		       u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm);
+#ifdef CONFIG_XFRM_OFFLOAD
+void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter);
+#else
+static inline void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter) { };
+#endif /* CONFIG_XFRM_OFFLOAD */
 #endif /* _IXGBE_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
new file mode 100644
index 0000000..14dd011
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -0,0 +1,157 @@
+/*******************************************************************************
+ *
+ * Intel 10 Gigabit PCI Express Linux driver
+ * Copyright(c) 2017 Oracle and/or its affiliates. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * The full GNU General Public License is included in this distribution in
+ * the file called "COPYING".
+ *
+ * Contact Information:
+ * Linux NICS <linux.nics@intel.com>
+ * e1000-devel Mailing List <e1000-devel@lists.sourceforge.net>
+ * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
+ *
+ ******************************************************************************/
+
+#include "ixgbe.h"
+
+/**
+ * ixgbe_ipsec_set_tx_sa - set the Tx SA registers
+ * @hw: hw specific details
+ * @idx: register index to write
+ * @key: key byte array
+ * @salt: salt bytes
+ **/
+static void ixgbe_ipsec_set_tx_sa(struct ixgbe_hw *hw, u16 idx,
+				  u32 key[], u32 salt)
+{
+	u32 reg;
+	int i;
+
+	for (i = 0; i < 4; i++)
+		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(i), cpu_to_be32(key[3-i]));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSTXSALT, cpu_to_be32(salt));
+	IXGBE_WRITE_FLUSH(hw);
+
+	reg = IXGBE_READ_REG(hw, IXGBE_IPSTXIDX);
+	reg &= IXGBE_RXTXIDX_IPS_EN;
+	reg |= idx << 3 | IXGBE_RXTXIDX_IDX_WRITE;
+	IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, reg);
+	IXGBE_WRITE_FLUSH(hw);
+}
+
+/**
+ * ixgbe_ipsec_set_rx_item - set an Rx table item
+ * @hw: hw specific details
+ * @idx: register index to write
+ * @tbl: table selector
+ *
+ * Trigger the device to store into a particular Rx table the
+ * data that has already been loaded into the input register
+ **/
+static void ixgbe_ipsec_set_rx_item(struct ixgbe_hw *hw, u16 idx, u32 tbl)
+{
+	u32 reg;
+
+	reg = IXGBE_READ_REG(hw, IXGBE_IPSRXIDX);
+	reg &= IXGBE_RXTXIDX_IPS_EN;
+	reg |= tbl | idx << 3 | IXGBE_RXTXIDX_IDX_WRITE;
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, reg);
+	IXGBE_WRITE_FLUSH(hw);
+}
+
+/**
+ * ixgbe_ipsec_set_rx_sa - set up the register bits to save SA info
+ * @hw: hw specific details
+ * @idx: register index to write
+ * @spi: security parameter index
+ * @key: key byte array
+ * @salt: salt bytes
+ * @mode: rx decrypt control bits
+ * @ip_idx: index into IP table for related IP address
+ **/
+static void ixgbe_ipsec_set_rx_sa(struct ixgbe_hw *hw, u16 idx, __be32 spi,
+				  u32 key[], u32 salt, u32 mode, u32 ip_idx)
+{
+	int i;
+
+	/* store the SPI (in bigendian) and IPidx */
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXSPI, spi);
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPIDX, ip_idx);
+	IXGBE_WRITE_FLUSH(hw);
+
+	ixgbe_ipsec_set_rx_item(hw, idx, IXGBE_RXIDX_TBL_SPI);
+
+	/* store the key, salt, and mode */
+	for (i = 0; i < 4; i++)
+		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(i), cpu_to_be32(key[3-i]));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXSALT, cpu_to_be32(salt));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXMOD, mode);
+	IXGBE_WRITE_FLUSH(hw);
+
+	ixgbe_ipsec_set_rx_item(hw, idx, IXGBE_RXIDX_TBL_KEY);
+}
+
+/**
+ * ixgbe_ipsec_set_rx_ip - set up the register bits to save SA IP addr info
+ * @hw: hw specific details
+ * @idx: register index to write
+ * @addr: IP address byte array
+ **/
+static void ixgbe_ipsec_set_rx_ip(struct ixgbe_hw *hw, u16 idx, u32 addr[])
+{
+	int i;
+
+	/* store the ip address */
+	for (i = 0; i < 4; i++)
+		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(i), addr[i]);
+	IXGBE_WRITE_FLUSH(hw);
+
+	ixgbe_ipsec_set_rx_item(hw, idx, IXGBE_RXIDX_TBL_IP);
+}
+
+/**
+ * ixgbe_ipsec_clear_hw_tables - because some tables don't get cleared on reset
+ * @adapter: board private structure
+ **/
+void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 buf[4] = {0, 0, 0, 0};
+	u16 idx;
+
+	/* disable Rx and Tx SA lookup */
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, 0);
+	IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, 0);
+
+	/* scrub the tables */
+	for (idx = 0; idx < IXGBE_IPSEC_MAX_SA_COUNT; idx++)
+		ixgbe_ipsec_set_tx_sa(hw, idx, buf, 0);
+
+	for (idx = 0; idx < IXGBE_IPSEC_MAX_SA_COUNT; idx++)
+		ixgbe_ipsec_set_rx_sa(hw, idx, 0, buf, 0, 0, 0);
+
+	for (idx = 0; idx < IXGBE_IPSEC_MAX_RX_IP_COUNT; idx++)
+		ixgbe_ipsec_set_rx_ip(hw, idx, buf);
+}
+
+/**
+ * ixgbe_init_ipsec_offload - initialize security registers for IPSec operation
+ * @adapter: board private structure
+ **/
+void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
+{
+	ixgbe_ipsec_clear_hw_tables(adapter);
+}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
new file mode 100644
index 0000000..017b13f
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
@@ -0,0 +1,50 @@
+/*******************************************************************************
+
+  Intel 10 Gigabit PCI Express Linux driver
+  Copyright(c) 2017 Oracle and/or its affiliates. All rights reserved.
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms and conditions of the GNU General Public License,
+  version 2, as published by the Free Software Foundation.
+
+  This program is distributed in the hope it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+  more details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program.  If not, see <http://www.gnu.org/licenses/>.
+
+  The full GNU General Public License is included in this distribution in
+  the file called "COPYING".
+
+  Contact Information:
+  Linux NICS <linux.nics@intel.com>
+  e1000-devel Mailing List <e1000-devel@lists.sourceforge.net>
+  Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
+
+*******************************************************************************/
+
+#ifndef _IXGBE_IPSEC_H_
+#define _IXGBE_IPSEC_H_
+
+#define IXGBE_IPSEC_MAX_SA_COUNT	1024
+#define IXGBE_IPSEC_MAX_RX_IP_COUNT	128
+#define IXGBE_IPSEC_BASE_RX_INDEX	IXGBE_IPSEC_MAX_SA_COUNT
+#define IXGBE_IPSEC_BASE_TX_INDEX	(IXGBE_IPSEC_MAX_SA_COUNT * 2)
+
+#define IXGBE_RXTXIDX_IPS_EN		0x00000001
+#define IXGBE_RXIDX_TBL_MASK		0x00000006
+#define IXGBE_RXIDX_TBL_IP		0x00000002
+#define IXGBE_RXIDX_TBL_SPI		0x00000004
+#define IXGBE_RXIDX_TBL_KEY		0x00000006
+#define IXGBE_RXTXIDX_IDX_MASK		0x00001ff8
+#define IXGBE_RXTXIDX_IDX_READ		0x40000000
+#define IXGBE_RXTXIDX_IDX_WRITE		0x80000000
+
+#define IXGBE_RXMOD_VALID		0x00000001
+#define IXGBE_RXMOD_PROTO_ESP		0x00000004
+#define IXGBE_RXMOD_DECRYPT		0x00000008
+#define IXGBE_RXMOD_IPV6		0x00000010
+
+#endif /* _IXGBE_IPSEC_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6d5f31e..51fb3cf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10327,6 +10327,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 					 NETIF_F_FCOE_MTU;
 	}
 #endif /* IXGBE_FCOE */
+	ixgbe_init_ipsec_offload(adapter);
 
 	if (adapter->flags2 & IXGBE_FLAG2_RSC_CAPABLE)
 		netdev->hw_features |= NETIF_F_LRO;
-- 
2.7.4

