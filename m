From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Aug 2016 15:05:28 -0700
Subject: [Intel-wired-lan] [PATCH v1 2/2] fm10k: don't re-map queues when a
	mailbox message suffices
In-Reply-To: <20160803220528.26222-1-jacob.e.keller@intel.com>
References: <20160803220528.26222-1-jacob.e.keller@intel.com>
Message-ID: <20160803220528.26222-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the PF assigns a new MAC Address to a VF, it uses a little register
trick to allow a later load of VF driver access to the MAC Address at
start without having to wait for a mailbox message. Unfortunately, to do
this the PF must assign ownership of the Queues and take it away from
the VF, otherwise writing these registers would be unsafe when the VF
driver is active.

This causes a potential race where a VF could try to access its queues
while they are owned by the PF. The fault detection code will prevent
this and issue a FUM fault error when the VF does this.

We can do better, by simply avoiding the register trick when it's not
necessary. We already have a mailbox message which indicates the new
MAC/VLAN pair. The PF currently attempts to send this message and
ignores failures which happen in the case where VF driver is not
loaded.

Fix this logic so that we always send the mailbox message first, then if
the mailbox errors due to no connected VF driver, we will fall back to
the register routine. This prevents using the pre-load method of writing
registers when we have an active VF driver, and thus prevents the need
to take queue ownership back. The whole logic is cleaner and avoids the
messy register interactions that could occur.

We still keep the register flow so that the PF can ensure a new driver
load will have the MAC Address at start without having to wait for the
PF to send a new mailbox message.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 682299dd0ce4..accfce8a6783 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -867,10 +867,6 @@ static s32 fm10k_iov_assign_default_mac_vlan_pf(struct fm10k_hw *hw,
 	vf_q_idx = fm10k_vf_queue_index(hw, vf_idx);
 	qmap_idx = qmap_stride * vf_idx;
 
-	/* MAP Tx queue back to 0 temporarily, and disable it */
-	fm10k_write_reg(hw, FM10K_TQMAP(qmap_idx), 0);
-	fm10k_write_reg(hw, FM10K_TXDCTL(vf_q_idx), 0);
-
 	/* Determine correct default VLAN ID. The FM10K_VLAN_OVERRIDE bit is
 	 * used here to indicate to the VF that it will not have privilege to
 	 * write VLAN_TABLE. All policy is enforced on the PF but this allows
@@ -886,9 +882,22 @@ static s32 fm10k_iov_assign_default_mac_vlan_pf(struct fm10k_hw *hw,
 	fm10k_tlv_attr_put_mac_vlan(msg, FM10K_MAC_VLAN_MSG_DEFAULT_MAC,
 				    vf_info->mac, vf_vid);
 
-	/* load onto outgoing mailbox, ignore any errors on enqueue */
-	if (vf_info->mbx.ops.enqueue_tx)
-		vf_info->mbx.ops.enqueue_tx(hw, &vf_info->mbx, msg);
+	/* try loading a message onto outgoing mailbox first */
+	if (vf_info->mbx.ops.enqueue_tx) {
+		err = vf_info->mbx.ops.enqueue_tx(hw, &vf_info->mbx, msg);
+		if (err != FM10K_MBX_ERR_NO_MBX)
+			return err;
+	}
+
+	/* If we aren't connected to a mailbox, this is most likely because
+	 * the VF driver is not running. It should thus be safe to re-map
+	 * queues and use the registers to pass the address and vlan so that
+	 * the VF driver gets correct information during its initialization.
+	 */
+
+	/* MAP Tx queue back to 0 temporarily, and disable it */
+	fm10k_write_reg(hw, FM10K_TQMAP(qmap_idx), 0);
+	fm10k_write_reg(hw, FM10K_TXDCTL(vf_q_idx), 0);
 
 	/* verify ring has disabled before modifying base address registers */
 	txdctl = fm10k_read_reg(hw, FM10K_TXDCTL(vf_q_idx));
-- 
2.9.2.701.gf965a18

