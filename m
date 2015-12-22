From: Gangfeng Huang <gangfeng.huang@ni.com>
Date: Tue, 22 Dec 2015 14:59:37 +0800
Subject: [Intel-wired-lan] [PATCH 3/3] igb: add support of Rx VLAN priority
	filters
In-Reply-To: <1450767577-21759-1-git-send-email-gangfeng.huang@ni.com>
References: <1450767577-21759-1-git-send-email-gangfeng.huang@ni.com>
Message-ID: <1450767577-21759-4-git-send-email-gangfeng.huang@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is meant to allow for nfc to insert and remove VLAN priority
filter by ethtool

Example:
Add an VLAN priority filter:
$ ethtool -N eth0 flow-type ether vlan 0x6000 vlan-mask 0x1FFF action 2 loc 1

Show all filters:
$ ethtool -n eth0
4 RX rings available
Total 1 rules

Filter: 1
	Flow Type: Raw Ethernet
	Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
	Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
	Ethertype: 0x0 mask: 0xFFFF
	VLAN EtherType: 0x0 mask: 0xffff
	VLAN: 0x6000 mask: 0x1fff
	User-defined: 0x0 mask: 0xffffffffffffffff
	Action: Direct to queue 2

Delete the filter by location:
$ ethtool -N delete 1

Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
---
 drivers/net/ethernet/intel/igb/e1000_defines.h |    5 ++
 drivers/net/ethernet/intel/igb/e1000_regs.h    |    1 +
 drivers/net/ethernet/intel/igb/igb.h           |    3 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c   |   89 ++++++++++++++++++++++--
 4 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index b191504..954ab3f 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -1019,4 +1019,9 @@
 #define E1000_RTTBCNRC_RF_INT_MASK	\
 	(E1000_RTTBCNRC_RF_DEC_MASK << E1000_RTTBCNRC_RF_INT_SHIFT)
 
+/* VLAN Priority Filter */
+#define E1000_VLAPQF_QUEUE_SEL(_n, q_idx) (q_idx << ((_n) * 4))
+#define E1000_VLAPQF_P_VALID(_n)          (0x1 << (3 + (_n) * 4))
+#define E1000_VLAPQF_QUEUE_MASK           0x03
+
 #endif
diff --git a/drivers/net/ethernet/intel/igb/e1000_regs.h b/drivers/net/ethernet/intel/igb/e1000_regs.h
index 4af2870..9168c7d 100644
--- a/drivers/net/ethernet/intel/igb/e1000_regs.h
+++ b/drivers/net/ethernet/intel/igb/e1000_regs.h
@@ -308,6 +308,7 @@
 					(0x054E0 + ((_i - 16) * 8)))
 #define E1000_RAH(_i)  (((_i) <= 15) ? (0x05404 + ((_i) * 8)) : \
 					(0x054E4 + ((_i - 16) * 8)))
+#define E1000_VLAPQF   0x055B0  /* VLAN Priority Queue Filter VLAPQF */
 #define E1000_IP4AT_REG(_i)     (0x05840 + ((_i) * 8))
 #define E1000_IP6AT_REG(_i)     (0x05880 + ((_i) * 4))
 #define E1000_WUPM_REG(_i)      (0x05A00 + ((_i) * 4))
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 17b4cd3..f06cfe2 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -364,6 +364,7 @@ struct hwmon_buff {
 
 enum igb_filter_match_flags {
 	IGB_FILTER_FLAG_ETHER_TYPE  = 0x1,
+	IGB_FILTER_FLAG_VLAN_TCI    = 0x2,
 };
 
 #define IGB_MAX_RXNFC_FILTERS 16
@@ -372,9 +373,11 @@ struct igb_nfc_input {
 	/* Byte layout in order, all values with MSB first:
 	* match_flags - 1 byte
 	* etype       - 2 bytes
+	* vlan_tci    - 2 bytes
 	*/
 	u8     match_flags;
 	__be16 etype;
+	__be16 vlan_tci;
 };
 
 /* board specific private data structure */
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 5766b57..a826735 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2439,11 +2439,18 @@ static int igb_get_ethtool_nfc_entry(struct igb_adapter *adapter,
 	if (!rule || fsp->location != rule->sw_idx)
 		return -EINVAL;
 
-	if (rule->filter.match_flags & IGB_FILTER_FLAG_ETHER_TYPE) {
+	if (rule->filter.match_flags) {
 		fsp->flow_type = ETHER_FLOW;
 		fsp->ring_cookie = rule->action;
-		fsp->h_u.ether_spec.h_proto = rule->filter.etype;
-		fsp->m_u.ether_spec.h_proto = ETHER_TYPE_FULL_MASK;
+		if (rule->filter.match_flags & IGB_FILTER_FLAG_ETHER_TYPE) {
+			fsp->h_u.ether_spec.h_proto = rule->filter.etype;
+			fsp->m_u.ether_spec.h_proto = ETHER_TYPE_FULL_MASK;
+		}
+		if (rule->filter.match_flags & IGB_FILTER_FLAG_VLAN_TCI) {
+			fsp->flow_type |= FLOW_EXT;
+			fsp->h_ext.vlan_tci = rule->filter.vlan_tci;
+			fsp->m_ext.vlan_tci = htons(VLAN_PRIO_MASK);
+		}
 		return 0;
 	}
 	return -EINVAL;
@@ -2687,12 +2694,46 @@ static int igb_rxnfc_write_etype_filter(struct igb_adapter *adapter,
 	return 0;
 }
 
+int igb_rxnfc_write_vlan_prio_filter(struct igb_adapter *adapter,
+				     struct igb_nfc_filter *input)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	u32 vlapqf;
+	u8 vlan_priority;
+	u16 queue_index;
+
+	vlapqf = rd32(E1000_VLAPQF);
+	vlan_priority = (ntohs(input->filter.vlan_tci) & VLAN_PRIO_MASK)
+				>> VLAN_PRIO_SHIFT;
+	queue_index = (vlapqf >> (vlan_priority * 4)) & E1000_VLAPQF_QUEUE_MASK;
+
+	/* check whether this vlan prio is already set */
+	if ((vlapqf & E1000_VLAPQF_P_VALID(vlan_priority)) &&
+	    (queue_index != input->action)) {
+		dev_err(&adapter->pdev->dev, "ethtool rxnfc set vlan prio filter failed.\n");
+		return -EEXIST;
+	}
+
+	vlapqf |= E1000_VLAPQF_P_VALID(vlan_priority);
+	vlapqf |= E1000_VLAPQF_QUEUE_SEL(vlan_priority, input->action);
+
+	wr32(E1000_VLAPQF, vlapqf);
+
+	return 0;
+}
+
 int igb_add_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
 {
 	int err = -EINVAL;
 
 	if (input->filter.match_flags & IGB_FILTER_FLAG_ETHER_TYPE) {
 		err = igb_rxnfc_write_etype_filter(adapter, input);
+		if (err)
+			return err;
+	}
+
+	if (input->filter.match_flags & IGB_FILTER_FLAG_VLAN_TCI)
+		err = igb_rxnfc_write_vlan_prio_filter(adapter, input);
 
 	return err;
 }
@@ -2712,11 +2753,33 @@ static void igb_clear_etype_filter_regs(struct igb_adapter *adapter,
 	adapter->etype_bitmap[reg_index] = false;
 }
 
+static void igb_clear_vlan_prio_filter(struct igb_adapter *adapter,
+				       u16 vlan_tci)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	u32 vlapqf;
+	u8 vlan_priority;
+
+	vlan_priority = (vlan_tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
+
+	vlapqf = rd32(E1000_VLAPQF);
+	vlapqf &= ~E1000_VLAPQF_P_VALID(vlan_priority);
+	vlapqf &= ~E1000_VLAPQF_QUEUE_SEL(vlan_priority,
+						E1000_VLAPQF_QUEUE_MASK);
+
+	wr32(E1000_VLAPQF, vlapqf);
+}
+
 int igb_erase_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
 {
 	if (input->filter.match_flags & IGB_FILTER_FLAG_ETHER_TYPE)
 		igb_clear_etype_filter_regs(adapter,
 					    input->etype_reg_index);
+
+	if (input->filter.match_flags & IGB_FILTER_FLAG_VLAN_TCI)
+		igb_clear_vlan_prio_filter(adapter,
+					   ntohs(input->filter.vlan_tci));
+
 	return 0;
 }
 
@@ -2798,15 +2861,28 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 	if ((fsp->flow_type & ~FLOW_EXT) != ETHER_FLOW)
 		return -EINVAL;
 
-	if (fsp->m_u.ether_spec.h_proto != ETHER_TYPE_FULL_MASK)
+	if (fsp->m_u.ether_spec.h_proto != ETHER_TYPE_FULL_MASK &&
+	    fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK))
 		return -EINVAL;
 
 	input = kzalloc(sizeof(*input), GFP_KERNEL);
 	if (!input)
 		return -ENOMEM;
 
-	input->filter.etype = fsp->h_u.ether_spec.h_proto;
-	input->filter.match_flags = IGB_FILTER_FLAG_ETHER_TYPE;
+	if (fsp->m_u.ether_spec.h_proto == ETHER_TYPE_FULL_MASK) {
+		input->filter.etype = fsp->h_u.ether_spec.h_proto;
+		input->filter.match_flags = IGB_FILTER_FLAG_ETHER_TYPE;
+	}
+
+	if ((fsp->flow_type & FLOW_EXT) && fsp->m_ext.vlan_tci) {
+		if (fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK)) {
+			err = -EINVAL;
+			goto err_out;
+		}
+		input->filter.vlan_tci = fsp->h_ext.vlan_tci;
+		input->filter.match_flags |= IGB_FILTER_FLAG_VLAN_TCI;
+	}
+
 	input->action = fsp->ring_cookie;
 	input->sw_idx = fsp->location;
 
@@ -2833,6 +2909,7 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 
 err_out_w_lock:
 	spin_unlock(&adapter->nfc_lock);
+err_out:
 	kfree(input);
 	return err;
 }
-- 
1.7.9.5

