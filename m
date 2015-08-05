From: Francois Romieu <romieu@fr.zoreil.com>
Date: Thu, 6 Aug 2015 00:52:37 +0200
Subject: [Intel-wired-lan] [PATCH 1/1 net-next] e1000: remove dead
 e1000_init_eeprom_params calls.
Message-ID: <20150805225237.GA31471@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The device probe method e1000_probe calls e1000_init_eeprom_params
itself so there's no reason to call it again from e1000_do_write_eeprom
or e1000_do_read_eeprom.

The sentence above assumes that e1000_init_eeprom_params is effective.
e1000_init_eeprom_params depends mostly on hw->mac_type and e1000_probe
bails out early if it can't set mac_type (see e1000_init_hw_struct, then
e1000_set_mac_type), qed.

Btw, if effective, the removed paths would had been deadlock prone when
e1000_eeprom_spi was set:
-> e1000_write_eeprom (takes e1000_eeprom_lock)
   -> e1000_do_write_eeprom
      -> e1000_init_eeprom_params
         -> e1000_read_eeprom (takes e1000_eeprom_lock)

(same narrative with e1000_read_eeprom -> e1000_do_read_eeprom etc.)

As a final note, the candidate deadlock above can't happen in e1000_probe
due to the way eeprom->word_size is set / tested.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
---

 Patch against davem's net-next as of 9dc20a649609c95ce7c5ac4282656ba627b67d49.

 I noticed these calls while looking at Joern Engel's e1000 eeprom read/write
 scheduler friendly patch.

 drivers/net/ethernet/intel/e1000/e1000_hw.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 45c8c864..b1af0d6 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -3900,10 +3900,6 @@ static s32 e1000_do_read_eeprom(struct e1000_hw *hw, u16 offset, u16 words,
 		return E1000_SUCCESS;
 	}
 
-	/* If eeprom is not yet detected, do so now */
-	if (eeprom->word_size == 0)
-		e1000_init_eeprom_params(hw);
-
 	/* A check for invalid values:  offset too large, too many words, and
 	 * not enough words.
 	 */
@@ -4074,10 +4070,6 @@ static s32 e1000_do_write_eeprom(struct e1000_hw *hw, u16 offset, u16 words,
 		return E1000_SUCCESS;
 	}
 
-	/* If eeprom is not yet detected, do so now */
-	if (eeprom->word_size == 0)
-		e1000_init_eeprom_params(hw);
-
 	/* A check for invalid values:  offset too large, too many words, and
 	 * not enough words.
 	 */
-- 
Ueimor
