From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 23:08:23 +0000
Subject: [Intel-wired-lan] [v4, 12/15] ice: Add stats and ethtool support
In-Reply-To: <20180320145819.19133-13-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-13-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F1B9@ORSMSX109.amr.corp.intel.com>
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
> Subject: [v4,12/15] ice: Add stats and ethtool support
> 
> This patch implements a watchdog task to get packet statistics from
> the device.
> 
> This patch also adds support for the following ethtool operations:
> 
> ethtool devname
> ethtool -s devname [msglvl N] [msglevel type on|off]
> ethtool -g|--show-ring devname
> ethtool -G|--set-ring devname [rx N] [tx N]
> ethtool -i|--driver devname
> ethtool -d|--register-dump devname [raw on|off] [hex on|off] [file name]
> ethtool -k|--show-features|--show-offload devname
> ethtool -K|--features|--offload devname feature on|off
> ethtool -P|--show-permaddr devname
> ethtool -S|--statistics devname
> ethtool -a|--show-pause devname
> ethtool -A|--pause devname [autoneg on|off] [rx on|off] [tx on|off]
> ethtool -r|--negotiate devname
> 
> CC: Andrew Lunn <andrew@lunn.ch>
> CC: Jakub Kicinski <kubakici@wp.pl>
> CC: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/ethernet/intel/ice/Makefile         |   3 +-
>  drivers/net/ethernet/intel/ice/ice.h            |  28 +-
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  43 ++
>  drivers/net/ethernet/intel/ice/ice_common.c     | 195 +++++
>  drivers/net/ethernet/intel/ice/ice_common.h     |   5 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c    | 954
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  80 ++
>  drivers/net/ethernet/intel/ice/ice_main.c       | 469 +++++++++++-
>  drivers/net/ethernet/intel/ice/ice_type.h       |  70 ++
>  9 files changed, 1842 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool.c

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


