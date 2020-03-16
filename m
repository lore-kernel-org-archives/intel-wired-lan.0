From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 16 Mar 2020 19:22:12 +0000
Subject: [Intel-wired-lan] [PATCH v3 5/9] ice: implement full NVM read
 from ETHTOOL_GEEPROM
In-Reply-To: <20200312015818.1007882-6-jacob.e.keller@intel.com>
References: <20200312015818.1007882-1-jacob.e.keller@intel.com>
 <20200312015818.1007882-6-jacob.e.keller@intel.com>
Message-ID: <a54d52e94c83415680501cc74777b91a@intel.com>
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
Subject: [Intel-wired-lan] [PATCH v3 5/9] ice: implement full NVM read from ETHTOOL_GEEPROM

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The current implementation of .get_eeprom only enables reading from the Shadow RAM portion of the NVM contents. Implement support for reading the entire flash contents instead of only the initial portion contained in the Shadow RAM.

A complete dump can take several seconds, but the ETHTOOL_GEEPROM ioctl is capable of reading only a limited portion at a time by specifying the offset and length to read.

In order to perform the reads directly, several functions are made non static. Additionally, the unused ice_read_sr_buf_aq and ice_read_sr_buf functions are removed.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.h  |   3 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  33 ++--
 drivers/net/ethernet/intel/ice/ice_nvm.c     | 150 +------------------
 drivers/net/ethernet/intel/ice/ice_nvm.h     |   4 +
 4 files changed, 26 insertions(+), 164 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


