From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu,  8 Mar 2018 14:52:11 -0800
Subject: [Intel-wired-lan] [S87 v5 7/7] i40e: restore TCPv4 input set when
 re-enabling ATR
In-Reply-To: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
References: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180308225211.12254-7-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When we re-enable ATR we need to restore the input set for TCPv4
filters, in order for ATR to function correctly. We already do this for
the normal case of re-enabling ATR when disabling ntuple support.
However, when re-enabling ATR after the last tcp4 filter is removed (but
when ntuple support is still active), we did not restore the TCPv4
filter input set.

This can cause problems if the TCPv4 filters from FDir had changed the
input set, as ATR will no longer behave as expected.

When clearing the ATR auto-disable flag, make sure we restore the TCPv4
input set to avoid this.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 89bcfd1c3213..0df21e4f2a0f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8157,6 +8157,15 @@ static void i40e_reenable_fdir_sb(struct i40e_pf *pf)
 static void i40e_reenable_fdir_atr(struct i40e_pf *pf)
 {
 	if (pf->flags & I40E_FLAG_FD_ATR_AUTO_DISABLED) {
+		/* ATR uses the same filtering logic as SB rules. It only
+		 * functions properly if the input set mask is at the default
+		 * settings. It is safe to restore the default input set
+		 * because there are no active TCPv4 filter rules.
+		 */
+		i40e_write_fd_input_set(pf, I40E_FILTER_PCTYPE_NONF_IPV4_TCP,
+					I40E_L3_SRC_MASK | I40E_L3_DST_MASK |
+					I40E_L4_SRC_MASK | I40E_L4_DST_MASK);
+
 		pf->flags &= ~I40E_FLAG_FD_ATR_AUTO_DISABLED;
 		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
 		    (I40E_DEBUG_FD & pf->hw.debug_mask))
-- 
2.14.3

