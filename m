From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 22:50:09 +0000
Subject: [Intel-wired-lan] [PATCH S21 03/14] ice: Add support for
 Forward Error Correction (FEC)
In-Reply-To: <20190416173503.29847-4-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
 <20190416173503.29847-4-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AF6D@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S21 03/14] ice: Add support for Forward
> Error Correction (FEC)
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> This patch adds driver support for Forward Error Correction (FEC) and ethtool
> handlers to set/get FEC params.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   4 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |  70 ++++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |   6 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 216 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  47 +++-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   9 +
>  6 files changed, 349 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


