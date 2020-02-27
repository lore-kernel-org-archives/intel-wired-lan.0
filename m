From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 27 Feb 2020 10:15:05 -0800
Subject: [Intel-wired-lan] [PATCH S40 15/15] ice: fix incorrect size
 description of ice_get_nvm_version
In-Reply-To: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
Message-ID: <20200227181505.61720-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The function comment for ice_get_nvm_version indicated that the ver_hi
and ver_lo values were 16 bits. In fact, they are only uint8_t values,
meaning that they have a maximum size of 8 bits. Fix the comment to
match the correct size.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index baca958ec760..68fea499f95c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -620,8 +620,8 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
  * @oem_ver: 8 bit NVM version
  * @oem_build: 16 bit NVM build number
  * @oem_patch: 8 NVM patch number
- * @ver_hi: high 16 bits of the NVM version
- * @ver_lo: low 16 bits of the NVM version
+ * @ver_hi: high 8 bits of the NVM version
+ * @ver_lo: low 8 bits of the NVM version
  */
 void
 ice_get_nvm_version(struct ice_hw *hw, u8 *oem_ver, u16 *oem_build,
-- 
2.20.1

