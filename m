From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 16 Mar 2020 20:22:22 +0000
Subject: [Intel-wired-lan] [PATCH v3 6/9] ice: enable initial devlink
 support
In-Reply-To: <20200312015818.1007882-7-jacob.e.keller@intel.com>
References: <20200312015818.1007882-1-jacob.e.keller@intel.com>
 <20200312015818.1007882-7-jacob.e.keller@intel.com>
Message-ID: <600873e52a72403e99af6aacc188489a@intel.com>
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
Subject: [Intel-wired-lan] [PATCH v3 6/9] ice: enable initial devlink support

Begin implementing support for the devlink interface with the ice driver.

The pf structure is currently memory managed through devres, via a devm_alloc. To mimic this behavior, after allocating the devlink pointer, use devm_add_action to add a teardown action for releasing the devlink memory on exit.

The ice hardware is a multi-function PCIe device. Thus, each physical function will get its own devlink instance. This means that each function will be treated independently, with its own parameters and configuration. This is done because the ice driver loads a separate instance for each function.

Due to this, the implementation does not enable devlink to manage device-wide resources or configuration, as each physical function will be treated independently. This is done for simplicity, as managing a devlink instance across multiple driver instances would significantly increase the complexity for minimal gain.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/Kconfig           |   1 +
 drivers/net/ethernet/intel/ice/Makefile      |   1 +
 drivers/net/ethernet/intel/ice/ice.h         |   4 +
 drivers/net/ethernet/intel/ice/ice_devlink.c | 117 +++++++++++++++++++  drivers/net/ethernet/intel/ice/ice_devlink.h |  14 +++
 drivers/net/ethernet/intel/ice/ice_main.c    |  33 +++++-
 6 files changed, 166 insertions(+), 4 deletions(-)  create mode 100644 drivers/net/ethernet/intel/ice/ice_devlink.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_devlink.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


