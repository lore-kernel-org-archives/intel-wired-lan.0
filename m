From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:12:51 +0000
Subject: [Intel-wired-lan] [PATCH v3 08/15] ice: Implement handlers for
 ethtool PHY/link operations
In-Reply-To: <20180809132958.23036-9-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-9-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545935@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 08/15] ice: Implement handlers for
> ethtool PHY/link operations
> 
> From: Chinh Cao <chinh.t.cao@intel.com>
> 
> This patch implements handlers for ethtool get_link_ksettings and
> set_link_ksettings. Helper functions use by these handlers are also
> introduced in this patch.
> 
> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   8 +-
>  drivers/net/ethernet/intel/ice/ice_common.c   | 121 ++-
>  drivers/net/ethernet/intel/ice/ice_common.h   |  14 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 802 +++++++++++++++++-
>  4 files changed, 892 insertions(+), 53 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


