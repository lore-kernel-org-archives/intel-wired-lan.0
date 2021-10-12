From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 11 Oct 2021 17:41:09 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 0/4] ice: miscellaneous
 firmware features
Message-ID: <20211012004113.1583133-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series contains a few miscellaneous left over pieces of work related to
flash update that I've been meaning to submit for a while.

This includes the following:

 * a new shadow-ram region similar to NVM region but for the device shadow
   RAM contents. This is distinct from NVM region because shadow RAM is
   built up during device init and may be different from the raw NVM flash
   data. (As I found out while debugging some issues with flash update).
 * refactoring of the ice_flash_pldm_image to become the main flash update
   entry point. This is simpler than having both a ice_devlink_flash_update
   and an ice_flash_pldm_image. It will make additions like dry-run easier
   in the future
 * support for firmware activation via devlink reload, when possible.

The major new work is the reload support, which allows activating firmware
immediately without a reboot when possible.

As a note, I want to call out that the reload support here only supports
firmware activation. I really did try to see what it would take to get
proper driver reload support working. Unfortunately this task requires a
large amount of rewrite to the entire flow that the driver uses for both
probe/remove, as well as driver reset.

Changes since v1:
* keep using ice_devlink_flash_update as the function entry point name,
  replacing ice_flash_pldm_image.
* fix the reload support to be less strict about when it will allow EMP
  reset. The previous behavior was overly strict and essentially did not
  allow reload in almost all cases.

Jacob Keller (4):
  ice: devlink: add shadow-ram region to snapshot Shadow RAM
  ice: move and rename ice_check_for_pending_update
  ice: move ice_devlink_flash_update and merge with ice_flash_pldm_image
  ice: support immediate firmware activation via devlink reload

 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   7 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  12 +
 drivers/net/ethernet/intel/ice/ice_devlink.c  | 205 +++++++++---
 .../net/ethernet/intel/ice/ice_fw_update.c    | 311 +++++++++++++-----
 .../net/ethernet/intel/ice/ice_fw_update.h    |   9 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
 7 files changed, 416 insertions(+), 134 deletions(-)


base-commit: 2d82122b64363fe17521f26b63a7c89b204d17eb
-- 
2.31.1.331.gb0c09ab8796f

