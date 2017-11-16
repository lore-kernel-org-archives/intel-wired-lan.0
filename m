From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 16 Nov 2017 11:54:41 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 3/9] ixgbe: add
 the ipsec support code files
In-Reply-To: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
References: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1510862087-1924-4-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This adds the ipsec support code into the driver, but doesn't yet
include it into the compile.

It is possible that the .h file contents could simply go into
the ixgbe_type.h and ixgbe.h files.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 1133 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h |   80 ++
 2 files changed, 1213 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
new file mode 100644
index 0000000..177b915
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -0,0 +1,1133 @@
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
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
+#include <linux/ipv6.h>
+#include <net/xfrm.h>
+#include <crypto/aead.h>
+
+#include "ixgbe.h"
+#include "ixgbe_type.h"
+#include "ixgbe_ipsec.h"
+
+/**
+ * ixgbe_ipsec_dump_info - dump in-memory SA tables for debugging
+ * @adapter: pointer to adapter structure
+ **/
+void ixgbe_ipsec_dump_info(struct ixgbe_adapter *adapter)
+{
+	struct net_device *dev = adapter->netdev;
+	int i;
+
+	netdev_info(dev, "IXGBE_IPSEC_INFO_DUMP\n");
+
+	netdev_info(dev, "  Tx SA table\n");
+	for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
+		struct tx_sa *tsa = &adapter->tx_sa_tbl[i];
+
+		if (!tsa->used)
+			continue;
+
+		netdev_info(dev, " tx_sa_tbl[%i] key = 0x%08x %08x %08x %08x\n",
+			    i, tsa->key[0], tsa->key[1],
+			    tsa->key[2], tsa->key[3]);
+		netdev_info(dev, "              salt = 0x%08x encrypt = %d\n",
+			    tsa->salt, tsa->encrypt);
+	}
+
+	netdev_info(dev, "  Rx SA table\n");
+	for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
+		struct rx_sa *rsa = &adapter->rx_sa_tbl[i];
+
+		if (!rsa->used)
+			continue;
+
+		netdev_info(dev, "rx_sa_tbl[%i] ipaddr = 0x%08x %08x %08x %08x\n",
+			    i, rsa->ipaddr[0], rsa->ipaddr[1],
+			    rsa->ipaddr[2], rsa->ipaddr[3]);
+		netdev_info(dev, "             spi = 0x%08x proto = 0x%x iptbl_ind = 0x%08x mode = 0x%04x\n",
+			    rsa->xs->id.spi, rsa->xs->id.proto,
+			    rsa->iptbl_ind, rsa->mode);
+		netdev_info(dev, "             key = 0x%08x %08x %08x %08x\n",
+			    rsa->key[0], rsa->key[1],
+			    rsa->key[2], rsa->key[3]);
+		netdev_info(dev, "             salt = 0x%08x decrypt = %d xs = %p\n",
+			    rsa->salt, rsa->decrypt, rsa->xs);
+	}
+
+	netdev_info(dev, "  Rx IP table\n");
+	for (i = 0; i < IXGBE_IPSEC_MAX_RX_IP_COUNT; i++) {
+		struct rx_ip_sa *ipsa = &adapter->rx_ip_sa_tbl[i];
+
+		if (!ipsa->used)
+			continue;
+
+		netdev_info(dev, "rx_ip_tbl[%i] ipaddr = 0x%08x %08x %08x %08x ref_cnt = 0x%08x\n",
+			    i, ipsa->ipaddr[0], ipsa->ipaddr[1],
+			    ipsa->ipaddr[2], ipsa->ipaddr[3],
+			    ipsa->ref_cnt);
+	}
+
+	netdev_info(dev, "  Offload counts\n");
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		struct ixgbe_ring *rx_ring = adapter->rx_ring[i];
+
+		if (rx_ring->rx_stats.ipsec_offloads ||
+		    rx_ring->rx_stats.ipsec_offload_faileds) {
+			netdev_info(dev, "rx_ring[%i] ipsec_offloads = %llu ipsec_offload_faileds = %llu\n",
+				    i, rx_ring->rx_stats.ipsec_offloads,
+				    rx_ring->rx_stats.ipsec_offload_faileds);
+		}
+	}
+}
+
+/**
+ * ixgbe_ipsec_dump_hw - dump the contents of the hw tables
+ * @adapter: pointer to adapter structure
+ **/
+void ixgbe_ipsec_dump_hw(struct ixgbe_adapter *adapter)
+{
+	struct net_device *dev = adapter->netdev;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int t_idx, i;
+	u32 reg;
+
+	netdev_info(dev, "IPsec HW\n");
+
+	netdev_info(dev, "SECRXCTRL=0x%08x  SECRXSTAT=0x%08x\n",
+		    IXGBE_READ_REG(hw, IXGBE_SECRXCTRL),
+		    IXGBE_READ_REG(hw, IXGBE_SECRXSTAT));
+
+	netdev_info(dev, "SECTXCTRL=0x%08x  SECTXSTAT=0x%08x, SECTXBUFFAF=0x%08x, SECTXMINIFG=0x%08x\n",
+		    IXGBE_READ_REG(hw, IXGBE_SECTXCTRL),
+		    IXGBE_READ_REG(hw, IXGBE_SECTXSTAT),
+		    IXGBE_READ_REG(hw, IXGBE_SECTXBUFFAF),
+		    IXGBE_READ_REG(hw, IXGBE_SECTXMINIFG));
+
+	netdev_info(dev, "RxIdx=0x%08x  TxIdx=0x%08x\n",
+		    IXGBE_READ_REG(hw, IXGBE_IPSRXIDX),
+		    IXGBE_READ_REG(hw, IXGBE_IPSTXIDX));
+
+	/* Tx SA Table */
+	netdev_info(dev, "Tx SA HW Table\n");
+	for (t_idx = 0; t_idx < IXGBE_IPSEC_MAX_SA_COUNT; t_idx++) {
+		u32 key[4];
+		u32 salt;
+		u32 anybit = 0;
+
+		reg = IXGBE_READ_REG(hw, IXGBE_IPSTXIDX);
+		reg &= IXGBE_RXTXIDX_IPS_EN;
+		reg |= t_idx << 3 | IXGBE_RXTXIDX_IDX_READ;
+		IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, reg);
+		for (i = 0; i < 4; i++) {
+			key[i] = IXGBE_READ_REG(hw, IXGBE_IPSTXKEY(i));
+			anybit |= key[i];
+		}
+		salt = IXGBE_READ_REG(hw, IXGBE_IPSTXSALT);
+		anybit |= salt;
+
+		if (anybit)
+			netdev_info(dev, "  SA[%d] key=0x%08x 0x%08x 0x%08x 0x%08x salt=0x%08x\n",
+				    t_idx, key[3], key[2], key[1], key[0],
+				    salt);
+	}
+
+	/* Rx SA Table */
+	netdev_info(dev, "Rx SA HW Table\n");
+	for (t_idx = 0; t_idx < IXGBE_IPSEC_MAX_SA_COUNT; t_idx++) {
+		u32 key[4];
+		u32 ip_idx;
+		__be32 spi;
+		u32 salt;
+		u32 mode;
+		u32 anybit = 0;
+
+		reg = IXGBE_READ_REG(hw, IXGBE_IPSRXIDX);
+		reg &= IXGBE_RXTXIDX_IPS_EN;
+		reg |= t_idx << 3 | IXGBE_RXTXIDX_IDX_READ | IXGBE_RXIDX_TBL_SPI;
+		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, reg);
+		spi = IXGBE_READ_REG(hw, IXGBE_IPSRXSPI);
+		ip_idx = IXGBE_READ_REG(hw, IXGBE_IPSRXIPIDX);
+
+		reg = IXGBE_READ_REG(hw, IXGBE_IPSRXIDX);
+		reg &= IXGBE_RXTXIDX_IPS_EN;
+		reg |= t_idx << 3 | IXGBE_RXTXIDX_IDX_READ | IXGBE_RXIDX_TBL_KEY;
+		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, reg);
+		for (i = 0; i < 4; i++) {
+			key[i] = IXGBE_READ_REG(hw, IXGBE_IPSRXKEY(i));
+			anybit |= key[i];
+		}
+		salt = IXGBE_READ_REG(hw, IXGBE_IPSRXSALT);
+		mode = IXGBE_READ_REG(hw, IXGBE_IPSRXMOD);
+
+		anybit |= salt | mode | spi | ip_idx;
+		if (anybit)
+			netdev_info(dev, "  SA[%d] spi=0x%08x key=0x%08x 0x%08x 0x%08x 0x%08x salt=0x%08x ipi=0x%08x mode=0x%08x\n",
+				    t_idx, spi, key[3], key[2], key[1], key[0],
+				    salt, ip_idx, mode);
+	}
+
+	/* Rx IP Table */
+	netdev_info(dev, "Rx IP HW Table\n");
+	for (t_idx = 0; t_idx < IXGBE_IPSEC_MAX_RX_IP_COUNT; t_idx++) {
+		u32 ipaddr[4];
+		u32 anybit = 0;
+
+		reg = IXGBE_READ_REG(hw, IXGBE_IPSRXIDX);
+		reg &= IXGBE_RXTXIDX_IPS_EN;
+		reg |= t_idx << 3 | IXGBE_RXTXIDX_IDX_READ | IXGBE_RXIDX_TBL_IP;
+		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, reg);
+		for (i = 0; i < 4; i++) {
+			ipaddr[i] = IXGBE_READ_REG(hw, IXGBE_IPSRXIPADDR(i));
+			anybit |= ipaddr[i];
+		}
+
+		if (anybit)
+			netdev_info(dev, "  IP[%d] 0x%08x 0x%08x 0x%08x 0x%08x\n",
+				    t_idx, ipaddr[0], ipaddr[1],
+				    ipaddr[2], ipaddr[3]);
+	}
+}
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
+ * @hw: hw specific details
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
+	adapter->num_tx_sa = 0;
+
+	for (idx = 0; idx < IXGBE_IPSEC_MAX_SA_COUNT; idx++)
+		ixgbe_ipsec_set_rx_sa(hw, idx, 0, buf, 0, 0, 0);
+	adapter->num_rx_sa = 0;
+
+	for (idx = 0; idx < IXGBE_IPSEC_MAX_RX_IP_COUNT; idx++)
+		ixgbe_ipsec_set_rx_ip(hw, idx, buf);
+}
+
+/**
+ * ixgbe_ipsec_stop_data
+ * @hw: hw specific details
+ **/
+static void ixgbe_ipsec_stop_data(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	bool link = adapter->link_up;
+	u32 t_rdy, r_rdy;
+	u32 reg;
+
+	/* halt data paths */
+	reg = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
+	reg |= IXGBE_SECTXCTRL_TX_DIS;
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, reg);
+
+	reg = IXGBE_READ_REG(hw, IXGBE_SECRXCTRL);
+	reg |= IXGBE_SECRXCTRL_RX_DIS;
+	IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, reg);
+
+	IXGBE_WRITE_FLUSH(hw);
+
+	/* If the tx fifo doesn't have link, but still has data,
+	 * we can't clear the tx sec block.  Set the MAC loopback
+	 * before block clear
+	 */
+	if (!link) {
+		reg = IXGBE_READ_REG(hw, IXGBE_MACC);
+		reg |= IXGBE_MACC_FLU;
+		IXGBE_WRITE_REG(hw, IXGBE_MACC, reg);
+
+		reg = IXGBE_READ_REG(hw, IXGBE_HLREG0);
+		reg |= IXGBE_HLREG0_LPBK;
+		IXGBE_WRITE_REG(hw, IXGBE_HLREG0, reg);
+
+		IXGBE_WRITE_FLUSH(hw);
+		mdelay(3);
+	}
+
+	/* wait for the paths to empty */
+	do {
+		mdelay(10);
+		t_rdy = IXGBE_READ_REG(hw, IXGBE_SECTXSTAT) &
+			IXGBE_SECTXSTAT_SECTX_RDY;
+		r_rdy = IXGBE_READ_REG(hw, IXGBE_SECRXSTAT) &
+			IXGBE_SECRXSTAT_SECRX_RDY;
+	} while (!t_rdy && !r_rdy);
+
+	/* undo loopback if we played with it earlier */
+	if (!link) {
+		reg = IXGBE_READ_REG(hw, IXGBE_MACC);
+		reg &= ~IXGBE_MACC_FLU;
+		IXGBE_WRITE_REG(hw, IXGBE_MACC, reg);
+
+		reg = IXGBE_READ_REG(hw, IXGBE_HLREG0);
+		reg &= ~IXGBE_HLREG0_LPBK;
+		IXGBE_WRITE_REG(hw, IXGBE_HLREG0, reg);
+
+		IXGBE_WRITE_FLUSH(hw);
+	}
+}
+
+/**
+ * ixgbe_ipsec_stop_engine
+ * @hw: hw specific details
+ **/
+static void ixgbe_ipsec_stop_engine(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 reg;
+
+	ixgbe_ipsec_stop_data(adapter);
+
+	/* disable Rx and Tx SA lookup */
+	IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, 0);
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, 0);
+
+	/* disable the Rx and Tx engines and full packet store-n-forward */
+	reg = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
+	reg |= IXGBE_SECTXCTRL_SECTX_DIS;
+	reg &= ~IXGBE_SECTXCTRL_STORE_FORWARD;
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, reg);
+
+	reg = IXGBE_READ_REG(hw, IXGBE_SECRXCTRL);
+	reg |= IXGBE_SECRXCTRL_SECRX_DIS;
+	IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, reg);
+
+	/* restore the "tx security buffer almost full threshold" to 0x250 */
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXBUFFAF, 0x250);
+
+	/* Set minimum IFG between packets back to the default 0x1 */
+	reg = IXGBE_READ_REG(hw, IXGBE_SECTXMINIFG);
+	reg = (reg & 0xfffffff0) | 0x1;
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXMINIFG, reg);
+
+	/* final set for normal (no ipsec offload) processing */
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, IXGBE_SECTXCTRL_SECTX_DIS);
+	IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, IXGBE_SECRXCTRL_SECRX_DIS);
+
+	IXGBE_WRITE_FLUSH(hw);
+}
+
+/**
+ * ixgbe_ipsec_start_engine
+ * @hw: hw specific details
+ *
+ * NOTE: this increases power consumption whether being used or not
+ **/
+static void ixgbe_ipsec_start_engine(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 reg;
+
+	ixgbe_ipsec_stop_data(adapter);
+
+	/* Set minimum IFG between packets to 3 */
+	reg = IXGBE_READ_REG(hw, IXGBE_SECTXMINIFG);
+	reg = (reg & 0xfffffff0) | 0x3;
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXMINIFG, reg);
+
+	/* Set "tx security buffer almost full threshold" to 0x15 so that the
+	 * almost full indication is generated only after buffer contains at
+	 * least an entire jumbo packet.
+	 */
+	reg = IXGBE_READ_REG(hw, IXGBE_SECTXBUFFAF);
+	reg = (reg & 0xfffffc00) | 0x15;
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXBUFFAF, reg);
+
+	/* restart the data paths by clearing the DISABLE bits */
+	IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, 0);
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, IXGBE_SECTXCTRL_STORE_FORWARD);
+
+	/* enable Rx and Tx SA lookup */
+	IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, IXGBE_RXTXIDX_IPS_EN);
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, IXGBE_RXTXIDX_IPS_EN);
+
+	IXGBE_WRITE_FLUSH(hw);
+}
+
+/**
+ * ixgbe_ipsec_restore - restore the ipsec HW settings after a reset
+ * @hw: hw specific details
+ **/
+void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 zbuf[4] = {0, 0, 0, 0};
+	int i;
+
+	if (!(adapter->flags2 & IXGBE_FLAG2_IPSEC_ENABLED))
+		return;
+
+	/* clean up the engine settings */
+	ixgbe_ipsec_stop_engine(adapter);
+
+	/* start the engine */
+	ixgbe_ipsec_start_engine(adapter);
+
+	/* reload the IP addrs */
+	for (i = 0; i < IXGBE_IPSEC_MAX_RX_IP_COUNT; i++) {
+		struct rx_ip_sa *ipsa = &adapter->rx_ip_sa_tbl[i];
+
+		if (ipsa->used)
+			ixgbe_ipsec_set_rx_ip(hw, i, ipsa->ipaddr);
+		else
+			ixgbe_ipsec_set_rx_ip(hw, i, zbuf);
+	}
+
+	/* reload the Rx keys */
+	for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
+		struct rx_sa *rsa = &adapter->rx_sa_tbl[i];
+
+		if (rsa->used)
+			ixgbe_ipsec_set_rx_sa(hw, i, rsa->xs->id.spi,
+					      rsa->key, rsa->salt,
+					      rsa->mode, rsa->iptbl_ind);
+		else
+			ixgbe_ipsec_set_rx_sa(hw, i, 0, zbuf, 0, 0, 0);
+	}
+
+	/* reload the Tx keys */
+	for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
+		struct tx_sa *tsa = &adapter->tx_sa_tbl[i];
+
+		if (tsa->used)
+			ixgbe_ipsec_set_tx_sa(hw, i, tsa->key, tsa->salt);
+		else
+			ixgbe_ipsec_set_tx_sa(hw, i, zbuf, 0);
+	}
+}
+
+/**
+ * ixgbe_ipsec_find_empty_idx - find the first unused security parameter index
+ * @adapter: pointer to adapter struct
+ * @rxtable: true if we need to look in the Rx table
+ *
+ * Returns the first unused index in either the Rx or Tx SA table
+ **/
+static int ixgbe_ipsec_find_empty_idx(struct ixgbe_adapter *adapter,
+				      bool rxtable)
+{
+	u32 i;
+
+	if (rxtable) {
+		if (adapter->num_rx_sa == IXGBE_IPSEC_MAX_SA_COUNT)
+			return -ENOSPC;
+
+		/* search rx sa table */
+		for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
+			if (!adapter->rx_sa_tbl[i].used)
+				return i;
+		}
+	} else {
+		if (adapter->num_rx_sa == IXGBE_IPSEC_MAX_SA_COUNT)
+			return -ENOSPC;
+
+		/* search tx sa table */
+		for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
+			if (!adapter->tx_sa_tbl[i].used)
+				return i;
+		}
+	}
+
+	return -ENOSPC;
+}
+
+/**
+ * ixgbe_ipsec_find_rx_state - find the state that matches
+ * @adapter: pointer to adapter struct
+ * @daddr: inbound address to match
+ * @proto: protocol to match
+ * @spi: SPI to match
+ *
+ * Returns a pointer to the matching SA state information
+ **/
+static struct xfrm_state *ixgbe_ipsec_find_rx_state(
+					struct ixgbe_adapter *adapter,
+					__be32 daddr, u8 proto, __be32 spi)
+{
+	struct rx_sa *rsa;
+	u32 i;
+
+	/* search rx sa table */
+	for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
+		rsa = &adapter->rx_sa_tbl[i];
+
+		if (!rsa->used)
+			continue;
+
+		if (spi == rsa->xs->id.spi &&
+		    daddr == rsa->xs->id.daddr.a4 &&
+		    proto == rsa->xs->id.proto) {
+			xfrm_state_hold(adapter->rx_sa_tbl[i].xs);
+			return adapter->rx_sa_tbl[i].xs;
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * ixgbe_ipsec_parse_proto_keys - find the key and salt based on the protocol
+ * @xs: pointer to xfrm_state struct
+ * @mykey: pointer to key array to populate
+ * @mysalt: pointer to salt value to populate
+ *
+ * This copies the protocol keys and salt to our own data tables.  The
+ * 82599 family only supports the one algorithm.
+ **/
+static int ixgbe_ipsec_parse_proto_keys(struct xfrm_state *xs,
+					u32 *mykey, u32 *mysalt)
+{
+	struct net_device *dev = xs->xso.dev;
+	unsigned char *key_data;
+	char *alg_name = NULL;
+	char *aes_gcm_name = "rfc4106(gcm(aes))";
+	int key_len;
+
+	if (xs->aead) {
+		key_data = &xs->aead->alg_key[0];
+		key_len = xs->aead->alg_key_len;
+		alg_name = xs->aead->alg_name;
+	} else {
+		netdev_err(dev, "Unsupported IPsec algorithm\n");
+		return -EINVAL;
+	}
+
+	if (strcmp(alg_name, aes_gcm_name)) {
+		netdev_err(dev, "Unsupported IPsec algorithm - please use %s\n",
+			   aes_gcm_name);
+		return -EINVAL;
+	}
+
+	/* 160 accounts for 16 byte key and 4 byte salt */
+	if (key_len == 128) {
+		netdev_info(dev, "IPsec hw offload parameters missing 32 bit salt value\n");
+	} else if (key_len != 160) {
+		netdev_err(dev, "IPsec hw offload only supports keys up to 128 bits with a 32 bit salt\n");
+		return -EINVAL;
+	}
+
+	/* The key bytes come down in a bigendian array of bytes, and
+	 * salt is always the last 4 bytes of the key array.
+	 * We don't need to do any byteswapping.
+	 */
+	memcpy(mykey, key_data, 16);
+	if (key_len == 160)
+		*mysalt = ((u32 *)key_data)[4];
+	else
+		*mysalt = 0;
+
+	return 0;
+}
+
+/**
+ * ixgbe_ipsec_add_sa - program device with a security association
+ * @xs: pointer to transformer state struct
+ **/
+static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
+{
+	struct net_device *dev = xs->xso.dev;
+	struct ixgbe_adapter *adapter = netdev_priv(dev);
+	struct ixgbe_hw *hw = &adapter->hw;
+	int checked, match, first;
+	u32 sa_idx;
+	int ret;
+	int i;
+
+	if (xs->id.proto != IPPROTO_ESP && xs->id.proto != IPPROTO_AH) {
+		netdev_err(dev, "Unsupported protocol 0x%04x for ipsec offload\n",
+			   xs->id.proto);
+		return -EINVAL;
+	}
+
+	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
+		struct rx_sa rsa;
+
+		if (xs->calg) {
+			netdev_err(dev, "Compression offload not supported\n");
+			return -EINVAL;
+		}
+
+		/* find the first unused index */
+		sa_idx = ixgbe_ipsec_find_empty_idx(adapter, true);
+		if (sa_idx < 0) {
+			netdev_err(dev, "No space for SA in Rx table!\n");
+			return -ENOSPC;
+		}
+
+		memset(&rsa, 0, sizeof(rsa));
+		rsa.used = true;
+		rsa.xs = xs;
+
+		if (rsa.xs->id.proto & IPPROTO_ESP)
+			rsa.decrypt = xs->ealg || xs->aead;
+
+		/* get the key and salt */
+		ret = ixgbe_ipsec_parse_proto_keys(xs, rsa.key, &rsa.salt);
+		if (ret) {
+			netdev_err(dev, "Failed to get key data for Rx SA table\n");
+			return ret;
+		}
+
+		/* get ip for rx sa table */
+		if (xs->xso.flags & XFRM_OFFLOAD_IPV6)
+			memcpy(rsa.ipaddr, &xs->id.daddr.a6, 16);
+		else
+			memcpy(&rsa.ipaddr[3], &xs->id.daddr.a4, 4);
+
+		/* The HW does not have a 1:1 mapping from keys to IP addrs, so
+		 * check for a matching IP addr entry in the table.  If the addr
+		 * already exists, use it; else find an unused slot and add the
+		 * addr.  If one does not exist and there are no unused table
+		 * entries, fail the request.
+		 */
+
+		/* Find an existing match or first not used, and stop looking
+		 * after we've checked all we know we have.
+		 */
+		checked = 0;
+		match = -1;
+		first = -1;
+		for (i = 0; i < IXGBE_IPSEC_MAX_RX_IP_COUNT &&
+			    (checked < adapter->num_rx_sa || first < 0); i++) {
+			if (adapter->rx_ip_sa_tbl[i].used) {
+				if (!memcmp(adapter->rx_ip_sa_tbl[i].ipaddr,
+					    rsa.ipaddr, sizeof(rsa.ipaddr))) {
+					match = i;
+					break;
+				}
+				checked++;
+			} else if (first < 0) {
+				first = i;  /* track the first empty seen */
+			}
+		}
+
+		if (adapter->num_rx_sa == 0)
+			first = 0;
+
+		if (match >= 0) {
+			/* addrs are the same, we should use this one */
+			rsa.iptbl_ind = match;
+			adapter->rx_ip_sa_tbl[match].ref_cnt++;
+
+		} else if (first >= 0) {
+			/* no matches, but here's an empty slot */
+			rsa.iptbl_ind = first;
+
+			memcpy(adapter->rx_ip_sa_tbl[first].ipaddr,
+			       rsa.ipaddr, sizeof(rsa.ipaddr));
+			adapter->rx_ip_sa_tbl[first].ref_cnt = 1;
+			adapter->rx_ip_sa_tbl[first].used = true;
+
+			ixgbe_ipsec_set_rx_ip(hw, rsa.iptbl_ind, rsa.ipaddr);
+
+		} else {
+			/* no match and no empty slot */
+			netdev_err(dev, "No space for SA in Rx IP SA table\n");
+			memset(&rsa, 0, sizeof(rsa));
+			return -ENOSPC;
+		}
+
+		rsa.mode = IXGBE_RXMOD_VALID;
+		if (rsa.xs->id.proto & IPPROTO_ESP)
+			rsa.mode |= IXGBE_RXMOD_PROTO_ESP;
+		if (rsa.decrypt)
+			rsa.mode |= IXGBE_RXMOD_DECRYPT;
+		if (rsa.xs->xso.flags & XFRM_OFFLOAD_IPV6)
+			rsa.mode |= IXGBE_RXMOD_IPV6;
+
+		/* the preparations worked, so save the info */
+		memcpy(&adapter->rx_sa_tbl[sa_idx], &rsa, sizeof(rsa));
+
+		ixgbe_ipsec_set_rx_sa(hw, sa_idx, rsa.xs->id.spi, rsa.key,
+				      rsa.salt, rsa.mode, rsa.iptbl_ind);
+		xs->xso.offload_handle = sa_idx + IXGBE_IPSEC_BASE_RX_INDEX;
+
+		adapter->num_rx_sa++;
+	} else {
+		struct tx_sa tsa;
+
+		/* find the first unused index */
+		sa_idx = ixgbe_ipsec_find_empty_idx(adapter, false);
+		if (sa_idx < 0) {
+			netdev_err(dev, "No space for SA in Tx table\n");
+			return -ENOSPC;
+		}
+
+		memset(&tsa, 0, sizeof(tsa));
+		tsa.used = true;
+		tsa.xs = xs;
+
+		if (xs->id.proto & IPPROTO_ESP)
+			tsa.encrypt = xs->ealg || xs->aead;
+
+		ret = ixgbe_ipsec_parse_proto_keys(xs, tsa.key, &tsa.salt);
+		if (ret) {
+			netdev_err(dev, "Failed to get key data for Tx SA table\n");
+			memset(&tsa, 0, sizeof(tsa));
+			return ret;
+		}
+
+		/* the preparations worked, so save the info */
+		memcpy(&adapter->tx_sa_tbl[sa_idx], &tsa, sizeof(tsa));
+
+		ixgbe_ipsec_set_tx_sa(hw, sa_idx, tsa.key, tsa.salt);
+
+		xs->xso.offload_handle = sa_idx + IXGBE_IPSEC_BASE_TX_INDEX;
+
+		adapter->num_tx_sa++;
+	}
+
+	/* enable the engine if not already warmed up */
+	if (!(adapter->flags2 & IXGBE_FLAG2_IPSEC_ENABLED)) {
+		ixgbe_ipsec_start_engine(adapter);
+		adapter->flags2 |= IXGBE_FLAG2_IPSEC_ENABLED;
+	}
+
+	return 0;
+}
+
+/**
+ * ixgbe_ipsec_del_sa - clear out this specific SA
+ * @xs: pointer to transformer state struct
+ **/
+static void ixgbe_ipsec_del_sa(struct xfrm_state *xs)
+{
+	struct net_device *dev = xs->xso.dev;
+	struct ixgbe_adapter *adapter = netdev_priv(dev);
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 zerobuf[4] = {0, 0, 0, 0};
+	u16 sa_idx;
+
+	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
+		struct rx_sa *rsa;
+		u8 iptbl_ind;
+
+		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
+		rsa = &adapter->rx_sa_tbl[sa_idx];
+
+		if (!rsa->used) {
+			netdev_err(dev, "Invalid Rx SA selected sa_idx=%d offload_handle=%lu\n",
+				   sa_idx, xs->xso.offload_handle);
+			return;
+		}
+
+		/* if the IP table entry is referenced by only this SA,
+		 * i.e. ref_cnt is only 1, clear the IP table entry as well
+		 */
+		iptbl_ind = rsa->iptbl_ind;
+		if (adapter->rx_ip_sa_tbl[iptbl_ind].ref_cnt > 0) {
+			adapter->rx_ip_sa_tbl[iptbl_ind].ref_cnt--;
+
+			if (!adapter->rx_ip_sa_tbl[iptbl_ind].ref_cnt) {
+				memset(&adapter->rx_ip_sa_tbl[iptbl_ind], 0,
+				       sizeof(struct rx_ip_sa));
+				ixgbe_ipsec_set_rx_ip(hw, iptbl_ind, zerobuf);
+			}
+		}
+
+		/* clear the SA table entry */
+		memset(rsa, 0, sizeof(struct rx_sa));
+		ixgbe_ipsec_set_rx_sa(hw, sa_idx, 0, zerobuf, 0, 0, 0);
+
+		adapter->num_rx_sa--;
+
+	} else {
+		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
+
+		if (!adapter->tx_sa_tbl[sa_idx].used) {
+			netdev_err(dev, "Invalid Tx SA selected sa_idx=%d offload_handle=%lu\n",
+				   sa_idx, xs->xso.offload_handle);
+			return;
+		}
+
+		/* clear the SA table entry */
+		memset(&adapter->tx_sa_tbl[sa_idx], 0, sizeof(struct tx_sa));
+		ixgbe_ipsec_set_tx_sa(hw, sa_idx, zerobuf, 0);
+
+		adapter->num_tx_sa--;
+	}
+
+	/* if there are no SAs left, stop the engine to save energy */
+	if (adapter->num_rx_sa == 0 && adapter->num_tx_sa == 0) {
+		adapter->flags2 &= ~IXGBE_FLAG2_IPSEC_ENABLED;
+		ixgbe_ipsec_stop_engine(adapter);
+	}
+}
+
+/**
+ * ixgbe_ipsec_free - called by xfrm garbage collections
+ * @xs: pointer to transformer state struct
+ *
+ * We don't have any garbage to collect, so we shouldn't even bother
+ * implementing this function.
+ **/
+static void ixgbe_ipsec_free(struct xfrm_state *xs)
+{
+}
+
+/**
+ * ixgbe_ipsec_offload_ok - can this packet use the xfrm hw offload
+ * @skb: current data packet
+ * @xs: pointer to transformer state struct
+ **/
+static bool ixgbe_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
+{
+	if (xs->props.family == AF_INET) {
+		/* Offload with IPv4 options is not supported yet */
+		if (ip_hdr(skb)->ihl > 5)
+			return false;
+	} else {
+		/* Offload with IPv6 extension headers is not support yet */
+		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
+			return false;
+	}
+
+	return true;
+}
+
+static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
+	.xdo_dev_state_add = ixgbe_ipsec_add_sa,
+	.xdo_dev_state_delete = ixgbe_ipsec_del_sa,
+	.xdo_dev_state_free = ixgbe_ipsec_free,
+	.xdo_dev_offload_ok = ixgbe_ipsec_offload_ok,
+};
+
+/**
+ * ixgbe_ipsec_tx - setup Tx flags for ipsec offload
+ * @tx_ring: outgoing context
+ * @skb: current data packet
+ * @itd: ipsec Tx data for later use in building context descriptor
+ **/
+int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring, struct sk_buff *skb,
+		   struct ixgbe_ipsec_tx_data *itd)
+{
+	struct ixgbe_adapter *adapter = netdev_priv(tx_ring->netdev);
+	struct xfrm_state *xs;
+	struct tx_sa *tsa;
+
+	/* TODO: not supporting IPv6 yet */
+	if (skb->protocol != htons(ETH_P_IP))
+		return 0;
+
+	if ((ip_hdr(skb)->protocol != IPPROTO_ESP) &&
+	    (ip_hdr(skb)->protocol != IPPROTO_AH))
+		return 0;
+
+	if (!skb->sp) {
+		netdev_err(tx_ring->netdev, "%s: no xfrm state skb->sp = %p encap=%d skb=%p\n",
+			   __func__, skb->sp, skb->encapsulation, skb);
+		return 0;
+	}
+
+	if (!skb->sp->len) {
+		netdev_err(tx_ring->netdev, "%s: no xfrm state len = %d\n",
+			   __func__, skb->sp->len);
+		return 0;
+	}
+
+	xs = xfrm_input_state(skb);
+	if (!xs) {
+		netdev_err(tx_ring->netdev, "%s: no xfrm_input_state() xs = %p\n",
+			   __func__, xs);
+		return 0;
+	}
+
+	itd->sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
+	if (itd->sa_idx < 0 || itd->sa_idx > IXGBE_IPSEC_MAX_SA_COUNT) {
+		netdev_err(tx_ring->netdev, "%s: bad sa_idx=%d\n",
+			   __func__, itd->sa_idx);
+		return 0;
+	}
+
+	tsa = &adapter->tx_sa_tbl[itd->sa_idx];
+	if (!tsa->used) {
+		netdev_err(tx_ring->netdev, "%s: unused sa_idx=%d\n",
+			   __func__, itd->sa_idx);
+		return 0;
+	}
+
+	itd->flags = 0;
+	if (xs->id.proto == IPPROTO_ESP) {
+		itd->flags |= IXGBE_ADVTXD_TUCMD_IPSEC_TYPE_ESP |
+			      IXGBE_ADVTXD_TUCMD_L4T_TCP;
+		if (skb->protocol == htons(ETH_P_IP))
+			itd->flags |= IXGBE_ADVTXD_TUCMD_IPV4;
+		itd->trailer_len = xs->props.trailer_len;
+	}
+	if (tsa->encrypt)
+		itd->flags |= IXGBE_ADVTXD_TUCMD_IPSEC_ENCRYPT_EN;
+
+	return 1;
+}
+
+/**
+ * ixgbe_ipsec_process_rx_offload - decode ipsec bits from Rx descriptor
+ * @rx_ring: receiving ring
+ * @rx_desc: receive data descriptor
+ * @skb: current data packet
+ *
+ * Determine if there was an ipsec encapsulation noticed, and if so set up
+ * the resulting status for later in the receive stack.
+ **/
+void ixgbe_ipsec_process_rx_offload(struct ixgbe_ring *rx_ring,
+				    union ixgbe_adv_rx_desc *rx_desc,
+				    struct sk_buff *skb)
+{
+	struct ixgbe_adapter *adapter = netdev_priv(rx_ring->netdev);
+	u16 pkt_info = le16_to_cpu(rx_desc->wb.lower.lo_dword.hs_rss.pkt_info);
+	u32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);
+	u16 ipsec_pkt_types = IXGBE_RXDADV_PKTTYPE_IPSEC_AH |
+				IXGBE_RXDADV_PKTTYPE_IPSEC_ESP;
+	struct xfrm_offload *xo = NULL;
+	struct xfrm_state *xs = NULL;
+	struct iphdr *iph;
+	u32 crypto_status = 0;
+	u8 *c_hdr;
+	__be32 spi;
+	u8 proto;
+
+	/* TODO: we're only handling ipv4 at the moment */
+	if (!(pkt_info & IXGBE_RXDADV_PKTTYPE_IPV4))
+		return;
+
+	/* look for our packet types */
+	if (!(pkt_info & ipsec_pkt_types))
+		return;
+
+	/* don't process this if no offload work was done */
+	if (!(status_error & IXGBE_RXDADV_STAT_SECP))
+		return;
+
+	iph = (struct iphdr *)(skb_mac_header(skb) + ETH_HLEN);
+	c_hdr = (u8 *)iph + iph->ihl * 4;
+	switch (pkt_info & ipsec_pkt_types) {
+	case IXGBE_RXDADV_PKTTYPE_IPSEC_AH:
+		spi = ((struct ip_auth_hdr *)c_hdr)->spi;
+		proto = IPPROTO_AH;
+		break;
+	case IXGBE_RXDADV_PKTTYPE_IPSEC_ESP:
+		spi = ((struct ip_esp_hdr *)c_hdr)->spi;
+		proto = IPPROTO_ESP;
+		break;
+	default:
+		spi = 0;
+		proto = 0;
+		break;
+	}
+
+	xs = ixgbe_ipsec_find_rx_state(adapter, iph->daddr, proto, spi);
+	if (unlikely(!xs))
+		return;
+
+	/* decode error bits, if any */
+	if ((status_error & IXGBE_RXDADV_ERR_IPSEC_AUTH_FAILED) == IXGBE_RXDADV_ERR_IPSEC_AUTH_FAILED) {
+		if (pkt_info & IXGBE_RXDADV_PKTTYPE_IPSEC_AH)
+			crypto_status = CRYPTO_TRANSPORT_AH_AUTH_FAILED;
+		else if (pkt_info & IXGBE_RXDADV_PKTTYPE_IPSEC_ESP)
+			crypto_status = CRYPTO_TRANSPORT_ESP_AUTH_FAILED;
+	} else if (status_error & IXGBE_RXDADV_ERR_IPSEC_INV_PROTOCOL) {
+		crypto_status = CRYPTO_INVALID_PROTOCOL;
+	} else if (status_error & IXGBE_RXDADV_ERR_IPSEC_INV_LENGTH) {
+		crypto_status = CRYPTO_INVALID_PACKET_SYNTAX;
+	} else {
+		crypto_status = CRYPTO_SUCCESS;
+	}
+
+	skb->sp = secpath_dup(skb->sp);
+	if (unlikely(!skb->sp))
+		return;
+
+	skb->sp->xvec[skb->sp->len++] = xs;
+	skb->sp->olen++;
+	xo = xfrm_offload(skb);
+	xo->flags = CRYPTO_DONE;
+	xo->status = crypto_status;
+
+	if (xo->status == CRYPTO_SUCCESS)
+		rx_ring->rx_stats.ipsec_offloads++;
+	else
+		rx_ring->rx_stats.ipsec_offload_faileds++;
+}
+
+/**
+ * ixgbe_init_ipsec_offload - initialize security registers for IPSec operation
+ * @adapter: board private structure
+ **/
+void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
+{
+	// TODO: enable and support checksum offload with ESP
+	//netdev_features_t esp_feats = NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM;
+	netdev_features_t esp_feats = NETIF_F_HW_ESP;
+	size_t size;
+
+	/* allocate SA tables for rx, tx, and ip table */
+	size = sizeof(struct rx_sa) * IXGBE_IPSEC_MAX_SA_COUNT;
+	adapter->rx_sa_tbl = kzalloc(size, GFP_KERNEL);
+	if (!adapter->rx_sa_tbl)
+		goto err;
+
+	size = sizeof(struct tx_sa) * IXGBE_IPSEC_MAX_SA_COUNT;
+	adapter->tx_sa_tbl = kzalloc(size, GFP_KERNEL);
+	if (!adapter->tx_sa_tbl)
+		goto err;
+
+	size = sizeof(struct rx_ip_sa) * IXGBE_IPSEC_MAX_RX_IP_COUNT;
+	adapter->rx_ip_sa_tbl = kzalloc(size, GFP_KERNEL);
+	if (!adapter->rx_ip_sa_tbl)
+		goto err;
+
+	adapter->num_rx_sa = 0;
+	adapter->num_tx_sa = 0;
+	ixgbe_ipsec_clear_hw_tables(adapter);
+	ixgbe_ipsec_stop_engine(adapter);
+
+	adapter->netdev->xfrmdev_ops = &ixgbe_xfrmdev_ops;
+	adapter->netdev->features |= esp_feats;
+	adapter->netdev->hw_enc_features |= esp_feats;
+
+	return;
+
+err:
+	kfree(adapter->rx_ip_sa_tbl);
+	kfree(adapter->rx_sa_tbl);
+	kfree(adapter->tx_sa_tbl);
+	netdev_err(adapter->netdev, "Unable to allocate memory for SA tables");
+}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
new file mode 100644
index 0000000..265950d
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
@@ -0,0 +1,80 @@
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
+struct rx_sa {
+	struct xfrm_state *xs;
+	u32 ipaddr[4];
+	u32 key[4];
+	u32 salt;
+	u32 mode;
+	u8  iptbl_ind;
+	bool used;
+	bool decrypt;
+};
+
+struct rx_ip_sa {
+	u32 ipaddr[4];
+	u32 ref_cnt;
+	bool used;
+};
+
+struct tx_sa {
+	struct xfrm_state *xs;
+	u32 key[4];
+	u32 salt;
+	bool encrypt;
+	bool used;
+};
+
+struct ixgbe_ipsec_tx_data {
+	u32 flags;
+	u16 trailer_len;
+	u16 sa_idx;
+};
+#endif /* _IXGBE_IPSEC_H_ */
-- 
2.7.4

