From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 26 Aug 2020 11:14:47 -0700
Subject: [Intel-wired-lan] [PATCH net 1/2] ice: increase maximum wait time
 for flash write commands
Message-ID: <20200826181448.1176594-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ice driver needs to wait for a firmware response to each command to
write a block of data to the scratch area used to update the device
firmware. The driver currently waits for up to 1 second for this to be
returned.

It turns out that firmware might take longer than 1 second to return
a completion in some cases. If this happens, the flash update will fail
to complete.

Fix this by increasing the maximum time that the driver will wait for
both writing a block of data, and for activating the new NVM bank. The
timeout for an erase command is already several minutes, as the firmware
had to erase the entire bank which was already expected to take a minute
or more in the worst case.

In the case where firmware really won't respond, we will now take longer
to fail. However, this ensures that if the firmware is simply slow to
respond, the flash update can still complete. This new maximum timeout
should not adversely increase the update time, as the implementation for
wait_event_interruptible_timeout, and should wake very soon after we get
a completion event. It is better for a flash update be slow but still
succeed than to fail because we gave up too quickly.

Fixes: d69ea414c9b4 ("ice: implement device flash update via devlink")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fw_update.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index deaefe00c9c0..29397a83699d 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -289,7 +289,13 @@ ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
 		return -EIO;
 	}
 
-	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_write, HZ, &event);
+	/* In most cases, firmware reports a write completion within a few
+	 * milliseconds. However, it has been observed that a completion might
+	 * take more than a second to complete in some cases. The timeout here
+	 * is conservative and is intended to prevent failure to update when
+	 * firmware is slow to respond.
+	 */
+	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_write, 15*HZ, &event);
 	if (err) {
 		dev_err(dev, "Timed out waiting for firmware write completion for module 0x%02x, err %d\n",
 			module, err);
@@ -513,7 +519,7 @@ static int ice_switch_flash_banks(struct ice_pf *pf, u8 activate_flags,
 		return -EIO;
 	}
 
-	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_write_activate, HZ,
+	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_write_activate, 30*HZ,
 				    &event);
 	if (err) {
 		dev_err(dev, "Timed out waiting for firmware to switch active flash banks, err %d\n",

base-commit: e093edc6dd0815cc0b328cb888262f6315ba018a
-- 
2.28.0.218.ge27853923b9d.dirty

