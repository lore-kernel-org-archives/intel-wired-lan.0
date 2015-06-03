From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 16:31:08 -0700
Subject: [Intel-wired-lan] [rc2 11/15] fm10k: re-map all possible VF queues
	after a VFLR
In-Reply-To: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
References: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1433374272-6684-12-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

During initialization, the VF counts its rings by walking the TQDLOC
registers. This works only if the TQMAP/RQMAP registers are set to map
all of the out-of-bound rings back to the first one. This allows the VF
to cleanly detect when it has run out of queues. Update the PF code so
that it resets the empty TQMAP/RQMAP registers post-VFLR to prevent
innocent VF drivers from triggering malicious driver events.

Signed-off-by: Matthew Vick <matthew.vick@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 891e21874b2a..3b942061a339 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1046,6 +1046,12 @@ static s32 fm10k_iov_reset_resources_pf(struct fm10k_hw *hw,
 		fm10k_write_reg(hw, FM10K_RQMAP(qmap_idx + i), vf_q_idx + i);
 	}
 
+	/* repeat the first ring for all the remaining VF rings */
+	for (i = queues_per_pool; i < qmap_stride; i++) {
+		fm10k_write_reg(hw, FM10K_TQMAP(qmap_idx + 1), vf_q_idx);
+		fm10k_write_reg(hw, FM10K_RQMAP(qmap_idx + 1), vf_q_idx);
+	}
+
 	return 0;
 }
 
-- 
2.1.0

