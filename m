From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:46 -0800
Subject: [Intel-wired-lan] [PART2 PATCH 3/9] i40e: restore default input set
	for each flow type
In-Reply-To: <20170206223852.31177-1-jacob.e.keller@intel.com>
References: <20170206223852.31177-1-jacob.e.keller@intel.com>
Message-ID: <20170206223852.31177-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Ensure that the default input set is correctly reprogrammed when
cleaning up after disabling flow director support. This ensures that the
programmed value will be in a clean state.

Although we do not yet have support for SCTPv4 filters, a future patch
will add support for this protocol, so we will correctly restore the
SCTPv4 input set here as well. Note that strictly speaking the default
hardware value for SCTP includes matching the verification tag. However,
the ethtool API does not have support for specifying this value, so
there is no reason to keep the verification field enabled.

This patch is the next step on the way to enabling partial tuple filters
which will be implemented in a following patch.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-Id: c22e1c267ae37518bb036aca4a5694681449f283
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 18 ++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index c32658ca5c22..4d54d5005ad3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -761,6 +761,24 @@ static inline u64 i40e_read_fd_input_set(struct i40e_pf *pf, u16 addr)
 	return val;
 }
 
+/**
+ * i40e_write_fd_input_set - writes value into flow director input set register
+ * @pf: pointer to the PF struct
+ * @addr: register addr
+ * @val: value to be written
+ *
+ * This function writes specified value to the register specified by 'addr'.
+ * This register is input set register based on flow-type.
+ **/
+static inline void i40e_write_fd_input_set(struct i40e_pf *pf,
+					   u16 addr, u64 val)
+{
+	i40e_write_rx_ctl(&pf->hw, I40E_PRTQF_FD_INSET(addr, 1),
+			  (u32)(val >> 32));
+	i40e_write_rx_ctl(&pf->hw, I40E_PRTQF_FD_INSET(addr, 0),
+			  (u32)(val & 0xFFFFFFFFULL));
+}
+
 /* needed by i40e_ethtool.c */
 int i40e_up(struct i40e_vsi *vsi);
 void i40e_down(struct i40e_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c188559fc4ed..2c3a427f5b75 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5900,6 +5900,25 @@ static void i40e_fdir_filter_exit(struct i40e_pf *pf)
 	pf->fd_tcp4_filter_cnt = 0;
 	pf->fd_udp4_filter_cnt = 0;
 	pf->fd_ip4_filter_cnt = 0;
+
+	/* Reprogram the default input set for TCP/IPv4 */
+	i40e_write_fd_input_set(pf, I40E_FILTER_PCTYPE_NONF_IPV4_TCP,
+				I40E_L3_SRC_MASK | I40E_L3_DST_MASK |
+				I40E_L4_SRC_MASK | I40E_L4_DST_MASK);
+
+	/* Reprogram the default input set for UDP/IPv4 */
+	i40e_write_fd_input_set(pf, I40E_FILTER_PCTYPE_NONF_IPV4_UDP,
+				I40E_L3_SRC_MASK | I40E_L3_DST_MASK |
+				I40E_L4_SRC_MASK | I40E_L4_DST_MASK);
+
+	/* Reprogram the default input set for SCTP/IPv4 */
+	i40e_write_fd_input_set(pf, I40E_FILTER_PCTYPE_NONF_IPV4_SCTP,
+				I40E_L3_SRC_MASK | I40E_L3_DST_MASK |
+				I40E_L4_SRC_MASK | I40E_L4_DST_MASK);
+
+	/* Reprogram the default input set for Other/IPv4 */
+	i40e_write_fd_input_set(pf, I40E_FILTER_PCTYPE_NONF_IPV4_OTHER,
+				I40E_L3_SRC_MASK | I40E_L3_DST_MASK);
 }
 
 /**
-- 
2.12.0.rc0.151.g8a5726c42288

