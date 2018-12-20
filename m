From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 21:41:54 +0000
Subject: [Intel-wired-lan] [PATCH S10 14/15] ice: Add support for new
 PHY types
In-Reply-To: <20181219180334.1104-15-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
 <20181219180334.1104-15-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343AAD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, December 19, 2018 10:04 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S10 14/15] ice: Add support for new PHY
> types
> 
> This patch adds code for the detection and operation of several additional
> PHY types that support higher link speeds.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  39 +++-
>  drivers/net/ethernet/intel/ice/ice_common.c     | 124 ++++++++++-
>  drivers/net/ethernet/intel/ice/ice_common.h     |   3 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c    | 262
> +++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h  |   2 +
>  drivers/net/ethernet/intel/ice/ice_sriov.c      |   9 +
>  drivers/net/ethernet/intel/ice/ice_type.h       |   2 +
>  7 files changed, 418 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


