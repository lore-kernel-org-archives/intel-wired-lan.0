From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 27 Oct 2021 15:49:46 -0700
Subject: [Intel-wired-lan] [PATCH v6 1/2] ice: reduce time to read Option
 ROM CIVD data
Message-ID: <20211027224947.644211-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

During probe and device reset, the ice driver reads some data from the
NVM image as part of ice_init_nvm. Part of this data includes a section
of the Option ROM which contains version information.

The function ice_get_orom_civd_data is used to locate the '$CIV' data
section of the Option ROM.

Timing of ice_probe and ice_rebuild indicate that the
ice_get_orom_civd_data function takes about 10 seconds to finish
executing.

The function locates the section by scanning the Option ROM every 512
bytes. This requires a significant number of NVM read accesses, since
the Option ROM bank is 500KB. In the worst case it would take about 1000
reads. Worse, all PFs serialize this operation during reload because of
acquiring the NVM semaphore.

The CIVD section is located at the end of the Option ROM image data.
Unfortunately, the driver has no easy method to determine the offset
manually. Practical experiments have shown that the data could be at
a variety of locations, so simply reversing the scanning order is not
sufficient to reduce the overall read time.

Instead, copy the entire contents of the Option ROM into memory. This
allows reading the data using 4Kb pages instead of 512 bytes at a time.
This reduces the total number of firmware commands by a factor of 8. In
addition, reading the whole section together at once allows better
indication to firmware of when we're "done".

Re-write ice_get_orom_civd_data to allocate virtual memory to store the
Option ROM data. Copy the entire OptionROM contents at once using
ice_read_flash_module. Finally, use this memory copy to scan for the
'$CIV' section.

This change significantly reduces the time to read the Option ROM CIVD
section from ~10 seconds down to ~1 second. This has a significant
impact on the total time to complete a driver rebuild or probe.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c | 47 ++++++++++++++++++------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 941bfce97bf4..7fb34e1191d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -619,7 +619,7 @@ static int
 ice_get_orom_civd_data(struct ice_hw *hw, enum ice_bank_select bank,
 		       struct ice_orom_civd_info *civd)
 {
-	struct ice_orom_civd_info tmp;
+	u8 *orom_data;
 	int status;
 	u32 offset;
 
@@ -627,36 +627,59 @@ ice_get_orom_civd_data(struct ice_hw *hw, enum ice_bank_select bank,
 	 * The first 4 bytes must contain the ASCII characters "$CIV".
 	 * A simple modulo 256 sum of all of the bytes of the structure must
 	 * equal 0.
+	 *
+	 * The exact location is unknown and varies between images but is
+	 * usually somewhere in the middle of the bank. We need to scan the
+	 * Option ROM bank to locate it.
+	 *
+	 * It's significantly faster to read the entire Option ROM up front
+	 * using the maximum page size, than to read each possible location
+	 * with a separate firmware command.
 	 */
+	orom_data = vzalloc(hw->flash.banks.orom_size);
+	if (!orom_data)
+		return -ENOMEM;
+
+	status = ice_read_flash_module(hw, bank, ICE_SR_1ST_OROM_BANK_PTR, 0,
+				       orom_data, hw->flash.banks.orom_size);
+	if (status) {
+		ice_debug(hw, ICE_DBG_NVM, "Unable to read Option ROM data\n");
+		return status;
+	}
+
+	/* Scan the memory buffer to locate the CIVD data section */
 	for (offset = 0; (offset + 512) <= hw->flash.banks.orom_size; offset += 512) {
+		struct ice_orom_civd_info *tmp;
 		u8 sum = 0, i;
 
-		status = ice_read_flash_module(hw, bank, ICE_SR_1ST_OROM_BANK_PTR,
-					       offset, (u8 *)&tmp, sizeof(tmp));
-		if (status) {
-			ice_debug(hw, ICE_DBG_NVM, "Unable to read Option ROM CIVD data\n");
-			return status;
-		}
+		tmp = (struct ice_orom_civd_info *)&orom_data[offset];
 
 		/* Skip forward until we find a matching signature */
-		if (memcmp("$CIV", tmp.signature, sizeof(tmp.signature)) != 0)
+		if (memcmp("$CIV", tmp->signature, sizeof(tmp->signature)) != 0)
 			continue;
 
+		ice_debug(hw, ICE_DBG_NVM, "Found CIVD section at offset %u\n",
+			  offset);
+
 		/* Verify that the simple checksum is zero */
-		for (i = 0; i < sizeof(tmp); i++)
+		for (i = 0; i < sizeof(*tmp); i++)
 			/* cppcheck-suppress objectIndex */
-			sum += ((u8 *)&tmp)[i];
+			sum += ((u8 *)tmp)[i];
 
 		if (sum) {
 			ice_debug(hw, ICE_DBG_NVM, "Found CIVD data with invalid checksum of %u\n",
 				  sum);
-			return -EIO;
+			goto err_invalid_checksum;
 		}
 
-		*civd = tmp;
+		*civd = *tmp;
 		return 0;
 	}
 
+	ice_debug(hw, ICE_DBG_NVM, "Unable to locate CIVD data within the Option ROM\n");
+
+err_invalid_checksum:
+	vfree(orom_data);
 	return -EIO;
 }
 

base-commit: f52e48210595b1a21ec36f151f3c2b1e5de6e5ca
-- 
2.31.1

