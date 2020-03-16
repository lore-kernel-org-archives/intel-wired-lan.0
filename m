From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 16 Mar 2020 19:18:22 +0000
Subject: [Intel-wired-lan] [PATCH v3 3/9] ice: store NVM version info in
 extracted format
In-Reply-To: <20200312015818.1007882-4-jacob.e.keller@intel.com>
References: <20200312015818.1007882-1-jacob.e.keller@intel.com>
 <20200312015818.1007882-4-jacob.e.keller@intel.com>
Message-ID: <f816e8904d804d49a813311c0fe227f8@intel.com>
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
Subject: [Intel-wired-lan] [PATCH v3 3/9] ice: store NVM version info in extracted format

The NVM version and Option ROM version information is stored within the struct ice_nvm_ver_info structure. The data for the NVM is stored as a 2byte value with the major and minor versions each using one byte from the field. The Option ROM is stored as a 4byte value that contains a major, build, and patch number.

Modify the code to immediately extract the version values and store them in a new struct ice_orom_info. Remove the now unnecessary ice_get_nvm_version function.

Update ice_ethtool.c to use the new fields directly from the structured data.

This reduces complexity of the code that prints these versions in ice_ethtool.c

Update the macro definitions and variable names to use the term "orom"
instead of "oem" for the Option ROM version. This helps increase the clarity of the Option ROM version code.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 23 -----  drivers/net/ethernet/intel/ice/ice_common.h  |  3 -  drivers/net/ethernet/intel/ice/ice_ethtool.c | 13 +--
 drivers/net/ethernet/intel/ice/ice_nvm.c     | 94 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_type.h    | 30 ++++---
 5 files changed, 88 insertions(+), 75 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


