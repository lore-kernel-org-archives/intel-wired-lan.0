From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Dec 2017 08:50:55 -0500
Subject: [Intel-wired-lan] [next PATCH S85-V1 10/14] i40e/i40evf: Don't
 bother setting the CLEARPBA bit
Message-ID: <20171229135055.14598-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The CLEARPBA bit in the dynamic interrupt control register actually has
no effect either way on the hardware. As per errata 28 in the XL710
specification update the interrupt is actually cleared any time the
register is written with the INTENA_MSK bit set to 0. As such the act of
toggling the enable bit actually will trigger the interrupt being
cleared and could lead to potential lost events if auto-masking is
not enabled.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 11 ++++++++++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 4e661ef..628ec59 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2267,8 +2267,17 @@ static u32 i40e_buildreg_itr(const int type, const u16 itr)
 {
 	u32 val;
 
+	/* We don't bother with setting the CLEARPBA bit as the data sheet
+	 * points out doing so is "meaningless since it was already
+	 * auto-cleared". The auto-clearing happens when the interrupt is
+	 * asserted.
+	 *
+	 * Hardware errata 28 for also indicates that writing to a
+	 * xxINT_DYN_CTLx CSR with INTENA_MSK (bit 31) set to 0 will clear
+	 * an event in the PBA anyway so we need to rely on the automask
+	 * to hold pending events for us until the interrupt is re-enabled
+	 */
 	val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
-	      I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
 	      (type << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT) |
 	      (itr << I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT);
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 3fd7e97..34d898f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1464,8 +1464,17 @@ static u32 i40e_buildreg_itr(const int type, const u16 itr)
 {
 	u32 val;
 
+	/* We don't bother with setting the CLEARPBA bit as the data sheet
+	 * points out doing so is "meaningless since it was already
+	 * auto-cleared". The auto-clearing happens when the interrupt is
+	 * asserted.
+	 *
+	 * Hardware errata 28 for also indicates that writing to a
+	 * xxINT_DYN_CTLx CSR with INTENA_MSK (bit 31) set to 0 will clear
+	 * an event in the PBA anyway so we need to rely on the automask
+	 * to hold pending events for us until the interrupt is re-enabled
+	 */
 	val = I40E_VFINT_DYN_CTLN1_INTENA_MASK |
-	      I40E_VFINT_DYN_CTLN1_CLEARPBA_MASK |
 	      (type << I40E_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
 	      (itr << I40E_VFINT_DYN_CTLN1_INTERVAL_SHIFT);
 
-- 
2.9.5

