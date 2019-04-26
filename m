From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 22:01:49 +0000
Subject: [Intel-wired-lan] [PATCH S19 13/15] ice: Fix couple of issues
 in ice_vsi_release
In-Reply-To: <20190416172439.27908-14-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
 <20190416172439.27908-14-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D399A2D@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S19 13/15] ice: Fix couple of issues in
> ice_vsi_release
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the driver is calling ice_napi_del() and then unregister_netdev().
> The call to unregister_netdev() will result in a call to ice_stop() and then
> ice_vsi_close(). This is where we call
> napi_disable() for all the MSI-X vectors. This flow is reversed so make the
> changes to ensure napi_disable() happens prior to napi_del().
> 
> Before calling napi_del() and free_netdev() make sure
> unregister_netdev() was called. This is done by making sure the
> __ICE_DOWN bit is set in the vsi->state for the interested VSI.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  1 -
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 24 ++++++++++++-----------
> drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
>  3 files changed, 14 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


