From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:35 -0800
Subject: [Intel-wired-lan] [PATCH S11 08/16] ice: fix numeric overflow
 warning
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-9-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

When compiling and analyzing the driver on newer kernels, a static
analyzer warns about the following "numeric overflow" issues:

  "The result of expression: 'budget-1' generates 4-byte type while casting
   to a bigger size of 8-byte".

  "The result of expression: '*words-words_read' generates 4-byte type
   while casting to a bigger size of 8-byte".

Fix them both.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> squashed commits]
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote commit message]
---
 drivers/net/ethernet/intel/ice/ice_nvm.c  | 7 ++++---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index ce64cecdae9c..413fdbbcc4d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -152,9 +152,10 @@ ice_read_sr_buf_aq(struct ice_hw *hw, u16 offset, u16 *words, u16 *data)
 		 */
 		off_w = offset % ICE_SR_SECTOR_SIZE_IN_WORDS;
 		read_size = off_w ?
-			min(*words,
-			    (u16)(ICE_SR_SECTOR_SIZE_IN_WORDS - off_w)) :
-			min((*words - words_read), ICE_SR_SECTOR_SIZE_IN_WORDS);
+			min_t(u16, *words,
+			      (ICE_SR_SECTOR_SIZE_IN_WORDS - off_w)) :
+			min_t(u16, (*words - words_read),
+			      ICE_SR_SECTOR_SIZE_IN_WORDS);
 
 		/* Check if this is last command, if so set proper flag */
 		if ((words_read + read_size) >= *words)
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 67d129bfe489..c289d97f477d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1169,7 +1169,7 @@ int ice_napi_poll(struct napi_struct *napi, int budget)
 		if (test_bit(ICE_FLAG_MSIX_ENA, pf->flags))
 			ice_update_ena_itr(vsi, q_vector);
 
-	return min(work_done, budget - 1);
+	return min_t(int, work_done, budget - 1);
 }
 
 /* helper function for building cmd/type/offset */
-- 
2.14.5

