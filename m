From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 27 Sep 2021 17:40:20 +0000
Subject: [Intel-wired-lan] [net-next 2/4] ice: move and rename
 ice_check_for_pending_update
In-Reply-To: <20210908234924.3416592-3-jacob.e.keller@intel.com>
References: <20210908234924.3416592-1-jacob.e.keller@intel.com>
 <20210908234924.3416592-3-jacob.e.keller@intel.com>
Message-ID: <BYAPR11MB336729CD2E84E71D75940975FCA79@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Thursday, September 9, 2021 5:19 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next 2/4] ice: move and rename
> ice_check_for_pending_update
> 
> The ice_devlink_flash_update function performs a few checks and then calls
> ice_flash_pldm_image. One of these checks is to call
> ice_check_for_pending_update. This function checks if the device has a
> pending update, and cancels it if so. This is necessary to allow a new flash
> update to proceed.
> 
> We want to refactor the ice code to eliminate ice_devlink_flash_update,
> moving its checks into ice_flash_pldm_image.
> 
> To do this, ice_check_for_pending_update will become static, and only called
> by ice_flash_pldm_image. To make this change easier to review, first just
> move the function up within the ice_fw_update.c file.
> 
> While at it, note that the function has a misleading name. Its primary action is
> to cancel a pending update. Using the verb "check" does not imply this.
> Rename it to ice_cancel_pending_update.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c  |   2 +-
>  .../net/ethernet/intel/ice/ice_fw_update.c    | 152 +++++++++---------
>  .../net/ethernet/intel/ice/ice_fw_update.h    |   4 +-
>  3 files changed, 79 insertions(+), 79 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
