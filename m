From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 10 Feb 2016 14:45:47 -0800
Subject: [Intel-wired-lan] [PATCH 2/6] fm10k: prevent possibly uninitialized
	variable
In-Reply-To: <1455144351-14758-1-git-send-email-jacob.e.keller@intel.com>
References: <1455144351-14758-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1455144351-14758-2-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

If 'attr_flag < (1 << (2 * FM10K_TEST_MSG_NESTED))' is ever false, err
will be used uninitialized.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
This is a direct copy of a patch authored by Bruce from our out of
tree driver, hence the authorship and signed-off-by.

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 7a959713daa3..0168ca6fcdff 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -1005,7 +1005,7 @@ static int fm10k_mbx_test(struct fm10k_intfc *interface, u64 *data)
 	struct fm10k_mbx_info *mbx = &hw->mbx;
 	u32 attr_flag, test_msg[6];
 	unsigned long timeout;
-	int err;
+	int err = -EINVAL;
 
 	/* For now this is a VF only feature */
 	if (hw->mac.type != fm10k_mac_vf)
-- 
2.7.0.236.gda096a0.dirty

