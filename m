From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 27 Sep 2021 17:39:13 +0000
Subject: [Intel-wired-lan] [net-next 3/4] ice: refactor
 ice_flash_pldm_image and combine with ice_devlink_flash_update
In-Reply-To: <20210908234924.3416592-4-jacob.e.keller@intel.com>
References: <20210908234924.3416592-1-jacob.e.keller@intel.com>
 <20210908234924.3416592-4-jacob.e.keller@intel.com>
Message-ID: <BYAPR11MB3367CDDE15181F344B459434FCA79@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next 3/4] ice: refactor ice_flash_pldm_image
> and combine with ice_devlink_flash_update
> 
> The ice_devlink_flash_update function performs a few upfront checks and
> then calls ice_flash_pldm_image.
> 
> Most of these checks actually make more sense within the context of
> ice_flash_pldm_image. Refactor this function to fit the argument format of
> the .flash_update devlink handler, and merge the checks from
> ice_devlink_flash_update.
> 
> Note that the check for overwrite mask was converted to a switch because it
> made the check easier to read by avoiding the massively long line or weird
> line breaks that were hard for my eyes to follow.
> 
> When moving the ice_cancel_pending_update function, notice that it also
> takes the NVM semaphore. The main flash update process also requires the
> NVM hardware semaphore. We can eliminate the call to get the semaphore
> from ice_cancel_pending_update by placing the check after we acquire the
> semaphore during ice_flash_pldm_image.
> 
> With this change, the ice_flash_pldm_image becomes the main entry point
> for the devlink flash update, eliminating some unnecessary boiler plate code.
> This also eases supporting a dry run with the PLDM library in a future change.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c  | 52 +-------------
>  .../net/ethernet/intel/ice/ice_fw_update.c    | 70 +++++++++++--------
>  .../net/ethernet/intel/ice/ice_fw_update.h    |  7 +-
>  3 files changed, 45 insertions(+), 84 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
