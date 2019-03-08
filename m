From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:33:31 +0000
Subject: [Intel-wired-lan] [PATCH S17 09/17] ice: Add ability to update
 rx-usecs-high
In-Reply-To: <20190228232603.32156-10-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
 <20190228232603.32156-10-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368EBA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S17 09/17] ice: Add ability to update rx-
> usecs-high
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the driver allows rx-usecs-high values to be set, but when querying
> the device for rx-usecs-high the value does not stick. This is because it was
> not yet implemented.
> Add code to allow the user to change rx-usecs-high and use this to set the
> q_vector's intrl value.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 31
> +++++++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.h    |  1 +
>  4 files changed, 33 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


