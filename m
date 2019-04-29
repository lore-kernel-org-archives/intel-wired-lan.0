From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Apr 2019 18:14:14 +0000
Subject: [Intel-wired-lan] [PATCH S20 06/15] ice: Add handler for
 ethtool selftest
In-Reply-To: <20190416173052.28928-7-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
 <20190416173052.28928-7-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AC88@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S20 06/15] ice: Add handler for ethtool
> selftest
> 
> This patch adds a handler for ethtool selftest. Selftest includes testing link,
> interrupts, eeprom, registers and packet loopback.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> squashed
> multiple commits]
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   8 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  23 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |  23 +
>  drivers/net/ethernet/intel/ice/ice_common.h   |   5 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 592 ++++++++++++++++++
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   4 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  44 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  33 +-
>  drivers/net/ethernet/intel/ice/ice_nvm.c      |  31 +
>  drivers/net/ethernet/intel/ice/ice_status.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>  11 files changed, 752 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


