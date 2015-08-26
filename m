From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 15:14:18 -0400
Subject: [Intel-wired-lan] [next PATCH S11 12/15] i40e: add little endian
	conversion for checksum
In-Reply-To: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440616461-110869-13-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The checksum is not correct on big endian machines so add code to swap it
correctly.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Ic92b886d172a2cbe49f5d7eee1bc78e447023c7b
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 3f2fec9..5475454 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -543,11 +543,13 @@ i40e_status i40e_update_nvm_checksum(struct i40e_hw *hw)
 {
 	i40e_status ret_code = 0;
 	u16 checksum;
+	__le16 le_sum;
 
 	ret_code = i40e_calc_nvm_checksum(hw, &checksum);
+	le_sum = cpu_to_le16(checksum);
 	if (!ret_code)
 		ret_code = i40e_write_nvm_aq(hw, 0x00, I40E_SR_SW_CHECKSUM_WORD,
-					     1, &checksum, true);
+					     1, &le_sum, true);
 
 	return ret_code;
 }
-- 
1.9.3

