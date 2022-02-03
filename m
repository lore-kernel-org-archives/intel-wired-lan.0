From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu,  3 Feb 2022 14:21:49 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Correct NVM checksum
 verification flow
Message-ID: <20220203122149.3298840-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update MAC type check e1000_pch_tgp because for e1000_pch_cnp,
NVM checksum update is still possible.
Emit a more detailed warning message.

Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1191663
Fixes: 4051f68318ca ("e1000e: Do not take care about recovery NVM checksum")
Reported-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index e298da712758..d60e2016d03c 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4140,9 +4140,9 @@ static s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
 		return ret_val;
 
 	if (!(data & valid_csum_mask)) {
-		e_dbg("NVM Checksum Invalid\n");
+		e_dbg("NVM Checksum valid bit not set\n");
 
-		if (hw->mac.type < e1000_pch_cnp) {
+		if (hw->mac.type < e1000_pch_tgp) {
 			data |= valid_csum_mask;
 			ret_val = e1000_write_nvm(hw, word, 1, &data);
 			if (ret_val)
-- 
2.30.2

