From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 16 Mar 2020 19:17:30 +0000
Subject: [Intel-wired-lan] [PATCH v3 2/9] ice: create function to read a
 section of the NVM and Shadow RAM
In-Reply-To: <20200312015818.1007882-3-jacob.e.keller@intel.com>
References: <20200312015818.1007882-1-jacob.e.keller@intel.com>
 <20200312015818.1007882-3-jacob.e.keller@intel.com>
Message-ID: <e6b9c97c293f4b2bad0d1935c8de05c5@intel.com>
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
Subject: [Intel-wired-lan] [PATCH v3 2/9] ice: create function to read a section of the NVM and Shadow RAM

The NVM contents are read via firmware by using the ice_aq_read_nvm function. This function has a couple of limits:

1) The AdminQ commands can only take buffers sized up to 4Kb. Thus, any
   larger read must be split into multiple reads.
2) when reading from the Shadow RAM, reads must not cross sector
   boundaries. The sectors are also 4Kb in size.

Implement the ice_read_flat_nvm function to read portions of the NVM by flat offset. That is, to read using offsets from the start of the NVM rather than from a specific module.

This function will be able to read both from the NVM and from the Shadow RAM. For simplicity NVM reads will always be broken up to not cross 4Kb page boundaries, even though this is not required unless reading from the Shadow RAM.

Use this new function as the implementation of ice_read_sr_word_aq.

The ice_read_sr_buf_aq function is not modified here. This is because a following change will remove the only caller of that function in favor of directly using ice_read_flat_nvm. Thus, there is little benefit to changing it now only to remove it momentarily. At the same time, the ice_read_sr_aq function will also be removed.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  2 +
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 87 +++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_nvm.h      |  3 +
 3 files changed, 85 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


