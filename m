From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 19 Aug 2020 14:58:35 -0700
Subject: [Intel-wired-lan] [PATCH 0/3] ice devlink updates
Message-ID: <20200819215838.3834786-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series includes a couple of minor cleanups in ice_devlink.c

First, Ani converts ice_info_get_dsn into a void function, as it always
returns success and does not need to conform to the factory pattern of the
other info reporting functions.

Second, Jake adds reporting of the DDP Track ID for the DDP package to
devlink info. The track ID is indicated as a bundle_id which refers to the
tracking identifier for the DDP package. This is similar to the fw.bundle_id
which refers to the main firmware block. This track ID is useful as the DDP
version alone is not enough to uniquely identify the DDP package.

Finally, Jake refactored the devlink_port to be tracked by the ice_vsi
structure instead of ice_pf. Doing so helps avoid some cleanup ordering
issues that resulted in possibly calling devlink_port_unregister twice, or
for a devlink_port that was never registered. Additionally, this paves the
way for a future addition of devlink_port for virtual functions and other
types of ports besides the main PF port.

Anirudh Venkataramanan (1):
  ice: Change ice_info_get_dsn to be void

Jacob Keller (2):
  ice: add the DDP Track ID to devlink info
  ice: refactor devlink_port to be per-VSI

 Documentation/networking/devlink/ice.rst     |  5 ++
 drivers/net/ethernet/intel/ice/ice.h         |  7 +-
 drivers/net/ethernet/intel/ice/ice_devlink.c | 72 ++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_devlink.h |  4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     |  5 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  8 +--
 6 files changed, 60 insertions(+), 41 deletions(-)


base-commit: 94f0e130c54caede97dd62d5fec8ada4142fe68f
-- 
2.28.0.218.ge27853923b9d.dirty

