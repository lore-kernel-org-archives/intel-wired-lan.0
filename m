From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 10 Jul 2017 13:23:10 -0700
Subject: [Intel-wired-lan] [PATCH v3 07/16] fm10k: don't loop while
	resetting VFs due to VFLR event
In-Reply-To: <20170710202319.22110-1-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
Message-ID: <20170710202319.22110-7-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We've always had a really weird looping construction for resetting VFs.
We read the VFLRE register and reset the VF if the corresponding bit is
set, which makes sense. However we loop continuously until we no longer
have any bits left unset. At first this makes sense, as a sort of "keep
trying until we succeed" concept.

Unfortunately this causes a problem if we happen to surprise remove
while this code is executing, because in this case we'll always read all
1s for the VFLRE register. This results in a hard lockup on the CPU
because the loop will never terminate.

Because our own reset function will clear the VFLR event register
always, (except when we've lost PCIe link obviously) there is no real
reason to loop. In practice, we'll loop over once and find that no VFs
are pending anymore.

Lets just check once. Since we're clear the notification when we reset
there's no benefit to the loop. Additionally, there shouldn't be a race
as future VLFRE events should trigger an interrupt. Additionally, we
didn't warn or do anything in the looped case anyways.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
index dfc88a463735..03897720bf0b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
@@ -66,23 +66,21 @@ s32 fm10k_iov_event(struct fm10k_intfc *interface)
 		goto read_unlock;
 
 	/* read VFLRE to determine if any VFs have been reset */
-	do {
-		vflre = fm10k_read_reg(hw, FM10K_PFVFLRE(1));
-		vflre <<= 32;
-		vflre |= fm10k_read_reg(hw, FM10K_PFVFLRE(0));
+	vflre = fm10k_read_reg(hw, FM10K_PFVFLRE(1));
+	vflre <<= 32;
+	vflre |= fm10k_read_reg(hw, FM10K_PFVFLRE(0));
 
-		i = iov_data->num_vfs;
+	i = iov_data->num_vfs;
 
-		for (vflre <<= 64 - i; vflre && i--; vflre += vflre) {
-			struct fm10k_vf_info *vf_info = &iov_data->vf_info[i];
+	for (vflre <<= 64 - i; vflre && i--; vflre += vflre) {
+		struct fm10k_vf_info *vf_info = &iov_data->vf_info[i];
 
-			if (vflre >= 0)
-				continue;
+		if (vflre >= 0)
+			continue;
 
-			hw->iov.ops.reset_resources(hw, vf_info);
-			vf_info->mbx.ops.connect(hw, &vf_info->mbx);
-		}
-	} while (i != iov_data->num_vfs);
+		hw->iov.ops.reset_resources(hw, vf_info);
+		vf_info->mbx.ops.connect(hw, &vf_info->mbx);
+	}
 
 read_unlock:
 	rcu_read_unlock();
-- 
2.13.0.615.gb09ed6e59a40

