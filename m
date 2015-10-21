From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 21 Oct 2015 19:47:07 -0400
Subject: [Intel-wired-lan] [next PATCH S19 06/15] i40e: Workaround fix for
	mss < 256 issue
In-Reply-To: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445471236-35918-7-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

HW/NVM sets a limit of no less than 256 bytes for MSS. Stack can send as
low as 76 bytes MSS. This patch lowers the HW limit to 64 bytes to avoid
MDDs from firing and causing a reset when the MSS is lower than 256.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I36b500a6bb227d283c3e321a7718e0672b11fab0

---
Testing-hints: 5644586
Set the mss to as low as 76 bytes using iperf3:
iperf3 -c 192.168.2.109 -B 192.168.2.108 -M 76
Check to see there are not resets and that the MSS for outbound packets
is as was set by the test.
 drivers/net/ethernet/intel/i40e/i40e_main.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a8fd031..c8727b8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6705,6 +6705,7 @@ static void i40e_reset_and_rebuild(struct i40e_pf *pf, bool reinit)
 	struct i40e_hw *hw = &pf->hw;
 	u8 set_fc_aq_fail = 0;
 	i40e_status ret;
+	u32 val;
 	u32 v;
 
 	/* Now we wait for GRST to settle out.
@@ -6843,6 +6844,20 @@ static void i40e_reset_and_rebuild(struct i40e_pf *pf, bool reinit)
 		}
 	}
 
+	/* Reconfigure hardware for allowing smaller MSS in the case
+	 * of TSO, so that we avoid the MDD being fired and causing
+	 * a reset in the case of small MSS+TSO.
+	 */
+#define I40E_REG_MSS          0x000E64DC
+#define I40E_REG_MSS_MIN_MASK 0x3FF0000
+#define I40E_64BYTE_MSS       0x400000
+	val = rd32(hw, I40E_REG_MSS);
+	if ((val & I40E_REG_MSS_MIN_MASK) > I40E_64BYTE_MSS) {
+		val &= ~I40E_REG_MSS_MIN_MASK;
+		val |= I40E_64BYTE_MSS;
+		wr32(hw, I40E_REG_MSS, val);
+	}
+
 	if (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 33)) ||
 	    (pf->hw.aq.fw_maj_ver < 4)) {
 		msleep(75);
@@ -10202,6 +10217,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	u16 link_status;
 	int err;
 	u32 len;
+	u32 val;
 	u32 i;
 	u8 set_fc_aq_fail;
 
@@ -10506,6 +10522,17 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			 i40e_stat_str(&pf->hw, err),
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
+	/* Reconfigure hardware for allowing smaller MSS in the case
+	 * of TSO, so that we avoid the MDD being fired and causing
+	 * a reset in the case of small MSS+TSO.
+	 */
+	val = rd32(hw, I40E_REG_MSS);
+	if ((val & I40E_REG_MSS_MIN_MASK) > I40E_64BYTE_MSS) {
+		val &= ~I40E_REG_MSS_MIN_MASK;
+		val |= I40E_64BYTE_MSS;
+		wr32(hw, I40E_REG_MSS, val);
+	}
+
 	if (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 33)) ||
 	    (pf->hw.aq.fw_maj_ver < 4)) {
 		msleep(75);
-- 
1.9.3

