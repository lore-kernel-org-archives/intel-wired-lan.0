From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 23:07:31 +0000
Subject: [Intel-wired-lan] [v4,
 11/15] ice: Add support for VLANs and offloads
In-Reply-To: <20180320145819.19133-12-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-12-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F1A3@ORSMSX109.amr.corp.intel.com>
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
> Subject: [v4,11/15] ice: Add support for VLANs and offloads
> 
> This patch adds support for VLANs. When a VLAN is created a switch filter
> is added to direct the VLAN traffic to the corresponding VSI. When a VLAN
> is deleted, the filter is deleted as well.
> 
> This patch also adds support for the following hardware offloads.
>     1) VLAN tag insertion/stripping
>     2) Receive Side Scaling (RSS)
>     3) Tx checksum and TCP segmentation
>     4) Rx checksum
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |  19 +
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  62 +++
>  drivers/net/ethernet/intel/ice/ice_common.c     | 188 ++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h     |  13 +
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h  | 169 +++++++
>  drivers/net/ethernet/intel/ice/ice_main.c       | 601
> +++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_switch.c     | 169 +++++++
>  drivers/net/ethernet/intel/ice/ice_switch.h     |   4 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c       | 405 +++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_txrx.h       |  17 +
>  10 files changed, 1631 insertions(+), 16 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


