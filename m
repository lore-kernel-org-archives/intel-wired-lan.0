From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Wed, 5 Dec 2018 13:54:26 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix race when the VF driver does a
 reset
Message-ID: <20181205135426.26431-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the VF driver does a reset, it (at least the Linux one) writes to
the VFCTRL register to issue a reset and then immediately sends a reset
message using the mailbox API. This is racy because when the PF driver
detects that the VFCTRL register reset pin has been asserted, it clears
the mailbox memory. Depending on ordering, the reset message sent by
the VF could be cleared by the PF driver. It then responds to the
cleared message with a NACK which causes the VF driver to malfunction.
Fix this by deferring clearing the mailbox memory until the reset
message is received.

Fixes: 939b701ad633 ("ixgbe: fix driver behaviour after issuing VFLR")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 5dacfc870259..345701af7749 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -700,7 +700,6 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
 	u8 num_tcs = adapter->hw_tcs;
 	u32 reg_val;
 	u32 queue;
-	u32 word;
 
 	/* remove VLAN filters beloning to this VF */
 	ixgbe_clear_vf_vlans(adapter, vf);
@@ -758,6 +757,14 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
 		}
 	}
 
+	IXGBE_WRITE_FLUSH(hw);
+}
+
+static void ixgbe_vf_clear_mbx(struct ixgbe_adapter *adapter, u32 vf)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 word;
+
 	/* Clear VF's mailbox memory */
 	for (word = 0; word < IXGBE_VFMAILBOX_SIZE; word++)
 		IXGBE_WRITE_REG_ARRAY(hw, IXGBE_PFMBMEM(vf), word, 0);
@@ -831,6 +838,8 @@ static int ixgbe_vf_reset_msg(struct ixgbe_adapter *adapter, u32 vf)
 	/* reset the filters for the device */
 	ixgbe_vf_reset_event(adapter, vf);
 
+	ixgbe_vf_clear_mbx(adapter, vf);
+
 	/* set vf mac address */
 	if (!is_zero_ether_addr(vf_mac))
 		ixgbe_set_vf_mac(adapter, vf, vf_mac);
-- 
2.17.1

