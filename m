From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 24 Aug 2015 17:02:01 -0700
Subject: [Intel-wired-lan] [next-queue] fm10k: do not assume VF always has 1
	queue
In-Reply-To: <1440460921-28318-1-git-send-email-jacob.e.keller@intel.com>
References: <1440460921-28318-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1440460921-28318-4-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It is possible that the PF has not yet assigned resources to the VF.
Although rare, this could result in the VF attempting to read queues it
does not own and result in FUM or THI faults in the PF. To prevent this,
check queue 0 before we continue in init_hw_vf.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
index 36c8b0aa08fd..4d1da54a061b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
@@ -103,7 +103,12 @@ static s32 fm10k_init_hw_vf(struct fm10k_hw *hw)
 	s32 err;
 	u16 i;
 
-	/* assume we always have at least 1 queue */
+	/* verify we have at least 1 queue */
+	if (!~FM10K_READ_REG(hw, FM10K_TXQCTL(0)) ||
+	    !~FM10K_READ_REG(hw, FM10K_RXQCTL(0)))
+		return FM10K_ERR_NO_RESOURCES;
+
+	/* determine how many queues we have */
 	for (i = 1; tqdloc0 && (i < FM10K_MAX_QUEUES_POOL); i++) {
 		/* verify the Descriptor cache offsets are increasing */
 		tqdloc = ~fm10k_read_reg(hw, FM10K_TQDLOC(i));
-- 
2.5.0.280.g4aaba03

