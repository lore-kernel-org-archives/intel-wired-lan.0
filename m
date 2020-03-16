From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 16 Mar 2020 20:24:25 +0000
Subject: [Intel-wired-lan] [PATCH v3 9/9] ice: add board identifier info
 to devlink .info_get
In-Reply-To: <20200312015818.1007882-10-jacob.e.keller@intel.com>
References: <20200312015818.1007882-1-jacob.e.keller@intel.com>
 <20200312015818.1007882-10-jacob.e.keller@intel.com>
Message-ID: <751159554ce04968aa92bc41b5f907be@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jacob Keller
Sent: Wednesday, March 11, 2020 6:58 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: [Intel-wired-lan] [PATCH v3 9/9] ice: add board identifier info to devlink .info_get

Export a unique board identifier using "board.id" for devlink's .info_get command.

Obtain this by reading the NVM for the PBA identification string.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 Documentation/networking/devlink/ice.rst     |   4 +
 drivers/net/ethernet/intel/ice/ice_common.c  |  66 ----------
 drivers/net/ethernet/intel/ice/ice_common.h  |   3 -
 drivers/net/ethernet/intel/ice/ice_devlink.c |  16 ++-
 drivers/net/ethernet/intel/ice/ice_nvm.c     | 125 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_nvm.h     |   5 +
 drivers/net/ethernet/intel/ice/ice_type.h    |   1 +
 7 files changed, 150 insertions(+), 70 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


