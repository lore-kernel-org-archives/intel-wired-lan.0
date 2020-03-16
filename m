From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 16 Mar 2020 19:21:28 +0000
Subject: [Intel-wired-lan] [PATCH v3 4/9] ice: discover and store size
 of available flash
In-Reply-To: <20200312015818.1007882-5-jacob.e.keller@intel.com>
References: <20200312015818.1007882-1-jacob.e.keller@intel.com>
 <20200312015818.1007882-5-jacob.e.keller@intel.com>
Message-ID: <4f91790a1dd34b549589f26715d0cacc@intel.com>
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
Subject: [Intel-wired-lan] [PATCH v3 4/9] ice: discover and store size of available flash

When reading from the NVM using a flat address, it is useful to know the upper bound on the size of the flash contents. This value is not stored within the NVM.

We can determine the size by performing a bisection between upper and lower bounds. It is known that the size cannot exceed 16 MB (offset of 0xFFFFFF).

Use a while loop to bisect the upper and lower bounds by reading one byte at a time. On a failed read, lower the maximum bound. On a successful read, increase the lower bound.

Save this as the flash_size in the ice_nvm_info structure that contains data related to the NVM.

The size will be used in a future patch for implementing full NVM read via ethtool's GEEPROM command.

The maximum possible size for the flash is bounded by the size limit for the NVM AdminQ commands. Add a new macro, ICE_AQC_NVM_MAX_OFFSET, which can be used to represent this upper bound.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  2 +
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 62 ++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
 3 files changed, 63 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


