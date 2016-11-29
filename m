From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 28 Nov 2016 16:06:02 -0800
Subject: [Intel-wired-lan] [next PATCH S55 05/14] i40e: refactor macro
	INTRL_USEC_TO_REG
In-Reply-To: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480377971-23412-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

This patch refactors the macro INTRL_USEC_TO_REG into a static inline
function and fixes a couple subtle bugs caused by the macro.

This patch fixes a bug which was caused by passing a bad register value
to the firmware.  If enabling interrupt rate limiting, a non-zero value
for the rate limit must be used.  Otherwise the firmware sets the
interrupt rate limit to the maximum value.  Due to the limited
resolution of the register, attempting to set a value of 1, 2, or 3
would be rounded down to 0 and limiting was left enabled, causing
unexpected behavior.

This patch also fixes a possible bug in which using the macro itself can
introduce unintended side-affects because the macro argument is used
more than once in the macro definition (e.g. a variable post-increment
argument would perform a double increment on the variable).

Without this patch, attempting to set interrupt rate limits of 1, 2, or
3 results in unexpected behavior and future use of this macro could
cause subtle bugs.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Change-Id: I83ac842de0ca9c86761923d6e3a4d7b1b95f2b3f
---
Testing-hints:
Use 'ethtool -C ethx rx-usecs-high xxx' to set different values for the
rate limit and 'idb ethx read 0x00035800' to observe register
PFINT_RATEN for values of 1, 2, 3, compared to 0 and 4.

HSDES-number: 1208935557

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 15 ++++++++++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 99772ee..977ae6f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2072,7 +2072,7 @@ static void i40e_set_itr_per_queue(struct i40e_vsi *vsi,
 	struct i40e_q_vector *q_vector;
 	u16 vector, intrl;
 
-	intrl = INTRL_USEC_TO_REG(vsi->int_rate_limit);
+	intrl = i40e_intrl_usec_to_reg(vsi->int_rate_limit);
 
 	vsi->rx_rings[queue]->rx_itr_setting = ec->rx_coalesce_usecs;
 	vsi->tx_rings[queue]->tx_itr_setting = ec->tx_coalesce_usecs;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 769f922..4b5f6c0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3263,7 +3263,7 @@ static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
 		wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, vector - 1),
 		     q_vector->tx.itr);
 		wr32(hw, I40E_PFINT_RATEN(vector - 1),
-		     INTRL_USEC_TO_REG(vsi->int_rate_limit));
+		     i40e_intrl_usec_to_reg(vsi->int_rate_limit));
 
 		/* Linked list for the queuepairs assigned to this vector */
 		wr32(hw, I40E_PFINT_LNKLSTN(vector - 1), qp);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index e065321..1ea820e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -52,7 +52,20 @@
  */
 #define INTRL_ENA                  BIT(6)
 #define INTRL_REG_TO_USEC(intrl) ((intrl & ~INTRL_ENA) << 2)
-#define INTRL_USEC_TO_REG(set) ((set) ? ((set) >> 2) | INTRL_ENA : 0)
+/**
+ * i40e_intrl_usec_to_reg - convert interrupt rate limit to register
+ * @intrl: interrupt rate limit to convert
+ *
+ * This function converts a decimal interrupt rate limit to the appropriate
+ * register format expected by the firmware when setting interrupt rate limit.
+ */
+static inline u16 i40e_intrl_usec_to_reg(int intrl)
+{
+	if (intrl >> 2)
+		return ((intrl >> 2) | INTRL_ENA);
+	else
+		return 0;
+}
 #define I40E_INTRL_8K              125     /* 8000 ints/sec */
 #define I40E_INTRL_62K             16      /* 62500 ints/sec */
 #define I40E_INTRL_83K             12      /* 83333 ints/sec */
-- 
2.4.11

