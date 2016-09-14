From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 14 Sep 2016 16:24:33 -0700
Subject: [Intel-wired-lan] [next PATCH S47 3/9] i40e: Bit test mask
	correction
In-Reply-To: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
References: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473895479-23035-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Filip Sadowski <filip.sadowski@intel.com>

Incorrect bit mask was used for testing "get link status" response.
Instead of I40E_AQ_LSE_ENABLE (which is actually 0x03) it most probably
should be I40E_AQ_LSE_IS_ENABLED (which is defined as 0x01).

Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
Change-ID: Ia199142906720507f847de3a33a25c61a9781b2f
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 2154a34..fe8100b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1849,7 +1849,7 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
 	else
 		hw_link_info->crc_enable = false;
 
-	if (resp->command_flags & cpu_to_le16(I40E_AQ_LSE_ENABLE))
+	if (resp->command_flags & cpu_to_le16(I40E_AQ_LSE_IS_ENABLED))
 		hw_link_info->lse_enable = true;
 	else
 		hw_link_info->lse_enable = false;
-- 
2.4.11

