From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 22:34:04 +0000
Subject: [Intel-wired-lan] [v4,
 01/15] ice: Add basic driver framework for Intel(R) E800 Series
In-Reply-To: <20180320145819.19133-2-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-2-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F0AD@ORSMSX109.amr.corp.intel.com>
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
> Subject: [v4,01/15] ice: Add basic driver framework for Intel(R) E800 Series
> 
> This patch adds a basic driver framework for the Intel(R) E800 Ethernet Series
> of network devices. There is no functionality right now other than the ability
> to load.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  Documentation/networking/ice.txt            |  39 +++++++
>  MAINTAINERS                                 |   1 +
>  drivers/net/ethernet/intel/Kconfig          |  14 +++
>  drivers/net/ethernet/intel/Makefile         |   1 +
>  drivers/net/ethernet/intel/ice/Makefile     |  27 +++++
>  drivers/net/ethernet/intel/ice/ice.h        |  48 ++++++++
>  drivers/net/ethernet/intel/ice/ice_devids.h |  33 ++++++
>  drivers/net/ethernet/intel/ice/ice_main.c   | 172
> ++++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_type.h   |  42 +++++++
>  9 files changed, 377 insertions(+)
>  create mode 100644 Documentation/networking/ice.txt  create mode
> 100644 drivers/net/ethernet/intel/ice/Makefile
>  create mode 100644 drivers/net/ethernet/intel/ice/ice.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_devids.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_main.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_type.h


Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


