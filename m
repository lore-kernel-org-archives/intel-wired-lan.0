From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 22:34:30 +0000
Subject: [Intel-wired-lan] [v4,
 02/15] ice: Add support for control queues
In-Reply-To: <20180320145819.19133-3-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-3-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F0C3@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Anirudh Venkataramanan
> [mailto:anirudh.venkataramanan at intel.com]
> Sent: Tuesday, March 20, 2018 7:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [v4,02/15] ice: Add support for control queues
> 
> A control queue is a hardware interface which is used by the driver
> to interact with other subsystems (like firmware, PHY, etc.). It is
> implemented as a producer-consumer ring. More specifically, an
> "admin queue" is a type of control queue used to interact with the
> firmware.
> 
> This patch introduces data structures and functions to initialize
> and teardown control/admin queues. Once the admin queue is initialized,
> the driver uses it to get the firmware version.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile         |   4 +-
>  drivers/net/ethernet/intel/ice/ice.h            |   1 +
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 108 +++
>  drivers/net/ethernet/intel/ice/ice_common.c     | 144 ++++
>  drivers/net/ethernet/intel/ice/ice_common.h     |  39 +
>  drivers/net/ethernet/intel/ice/ice_controlq.c   | 979
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_controlq.h   |  97 +++
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  46 ++
>  drivers/net/ethernet/intel/ice/ice_main.c       |  11 +-
>  drivers/net/ethernet/intel/ice/ice_osdep.h      |  86 +++
>  drivers/net/ethernet/intel/ice/ice_status.h     |  35 +
>  drivers/net/ethernet/intel/ice/ice_type.h       |  22 +
>  12 files changed, 1570 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_common.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_common.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_controlq.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_controlq.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_hw_autogen.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_osdep.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_status.h


Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


