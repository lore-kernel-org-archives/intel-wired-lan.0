From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  1 Oct 2020 10:31:40 -0700
Subject: [Intel-wired-lan] [intel-wired-lan 0/4] implement minimum security
 revision
Message-ID: <20201001173144.712615-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ice device has security revision fields associated with the ``fw.undi``
and ``fw.mgmt`` sections of the flash. Additionally each of these security
revisions has a minimum security revision device parameter.

The minimum security revision indicates the lowest security revision that
will be loaded by the device. If the associated flash section has a lower
security revision, the device will not load it.

Implement support for displaying and updating the minimum security revision
fields for the device as driver-specific devlink parameters.

Jacob Keller (4):
  ice: create flash_info structure and separate NVM version
  ice: cache NVM module bank information
  ice: read security revision to ice_nvm_info and ice_orom_info
  ice: add devlink parameters to read and write minimum security
    revision

 Documentation/networking/devlink/ice.rst      |  43 ++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  17 +
 drivers/net/ethernet/intel/ice/ice_devlink.c  | 254 ++++++++-
 drivers/net/ethernet/intel/ice/ice_devlink.h  |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   8 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   3 +
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 532 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_nvm.h      |   4 +
 drivers/net/ethernet/intel/ice/ice_type.h     |  91 ++-
 9 files changed, 888 insertions(+), 66 deletions(-)


base-commit: f2e834694b0d92187d889172da842e27829df371
-- 
2.28.0.497.g54e85e7af1ac

