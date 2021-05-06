From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 May 2021 08:39:58 -0700
Subject: [Intel-wired-lan] [PATCH S59 03/13] ice: add error message when
 pldmfw_flash_image fails
In-Reply-To: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
Message-ID: <20210506154008.12880-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When flashing a new firmware image onto the device, the pldmfw library
parses the image contents looking for a matching record. If no record
can be found, the function reports an error of -ENOENT. This can produce
a very confusing error message and experience for the user:

  $devlink dev flash pci/0000:ab:00.0 file image.bin
  devlink answers: No such file or directory

This is because the ENOENT error code is interpreted as a missing file
or directory. The pldmfw library does not have direct access to the
extack pointer as it is generic and non-netdevice specific. The only way
that ENOENT is returned by the pldmfw library is when no record matches.

Catch this specific error and report a suitable extended ack message:

  $devlink dev flash pci/0000:ab:00.0 file image.bin
  Error: ice: Firmware image has no record matching this device
  devlink answers: No such file or directory

In addition, ensure that we log an error message to the console whenever
this function fails. Because our driver specific PLDM operation
functions potentially set the extended ACK message, avoid overwriting
this with a generic message.

This change should result in an improved experience when attempting to
flash an image that does not have a compatible record.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fw_update.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index dcec0360ce55..f8601d5b0b19 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -702,6 +702,16 @@ int ice_flash_pldm_image(struct ice_pf *pf, const struct firmware *fw,
 	}
 
 	err = pldmfw_flash_image(&priv.context, fw);
+	if (err == -ENOENT) {
+		dev_err(dev, "Firmware image has no record matching this device\n");
+		NL_SET_ERR_MSG_MOD(extack, "Firmware image has no record matching this device");
+	} else if (err) {
+		/* Do not set a generic extended ACK message here. A more
+		 * specific message may already have been set by one of our
+		 * ops.
+		 */
+		dev_err(dev, "Failed to flash PLDM image, err %d", err);
+	}
 
 	ice_release_nvm(hw);
 
-- 
2.20.1

