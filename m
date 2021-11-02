From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 2 Nov 2021 08:12:47 +0000
Subject: [Intel-wired-lan] [PATCH v7 2/2] ice: support immediate
 firmware activation via devlink reload
In-Reply-To: <20211027232255.669167-2-jacob.e.keller@intel.com>
References: <20211027232255.669167-1-jacob.e.keller@intel.com>
 <20211027232255.669167-2-jacob.e.keller@intel.com>
Message-ID: <BYAPR11MB3367F5ACF0846C99CCB48580FC8B9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Thursday, October 28, 2021 4:53 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Intel Wired LAN <intel-
> wired-lan at lists.osuosl.org>
> Cc: pmenzel at molgen.mpg.de
> Subject: [Intel-wired-lan] [PATCH v7 2/2] ice: support immediate firmware
> activation via devlink reload
> 
> The ice hardware contains an embedded chip with firmware which can be
> updated using devlink flash. The firmware which runs on this chip is referred to
> as the Embedded Management Processor firmware (EMP firmware).
> 
> Activating the new firmware image currently requires that the system be
> rebooted. This is not ideal as rebooting the system can cause unwanted
> downtime.
> 
> In practical terms, activating the firmware does not always require a full
> system reboot. In many cases it is possible to activate the EMP firmware
> immediately. There are a couple of different scenarios to cover.
> 
>  * The EMP firmware itself can be reloaded by issuing a special update
>    to the device called an Embedded Management Processor reset (EMP
>    reset). This reset causes the device to reset and reload the EMP
>    firmware.
> 
>  * PCI configuration changes are only reloaded after a cold PCIe reset.
>    Unfortunately there is no generic way to trigger this for a PCIe
>    device without a system reboot.
> 
> When performing a flash update, firmware is capable of responding with some
> information about the specific update requirements.
> 
> The driver updates the flash by programming a secondary inactive bank with
> the contents of the new image, and then issuing a command to request to
> switch the active bank starting from the next load.
> 
> The response to the final command for updating the inactive NVM flash bank
> includes an indication of the minimum reset required to fully update the
> device. This can be one of the following:
> 
>  * A full power on is required
>  * A cold PCIe reset is required
>  * An EMP reset is required
> 
> The response to the command to switch flash banks includes an indication of
> whether or not the firmware will allow an EMP reset request.
> 
> For most updates, an EMP reset is sufficient to load the new EMP firmware
> without issues. In some cases, this reset is not sufficient because the PCI
> configuration space has changed. When this could cause incompatibility with
> the new EMP image, the firmware is capable of rejecting the EMP reset
> request.
> 
> Add logic to ice_fw_update.c to handle the response data flash update AdminQ
> commands.
> 
> For the reset level, issue a devlink status notification informing the user of how
> to complete the update with a simple suggestion like "Activate new firmware
> by rebooting the system".
> 
> Cache the status of whether or not firmware will restrict the EMP reset for use
> in implementing devlink reload.
> 
> Implement support for devlink reload with the "fw_activate" flag. This allows
> user space to request the firmware be activated immediately.
> 
> For the .reload_down handler, we will issue a request for the EMP reset using
> the appropriate firmware AdminQ command. If we know that the firmware will
> not allow an EMP reset, simply exit with a suitable netlink extended ACK
> message indicating that the EMP reset is not available.
> 
> For the .reload_up handler, simply wait until the driver has finished resetting.
> Logic to handle processing of an EMP reset already exists in the driver as part
> of its reset and rebuild flows.
> 
> Implement support for the devlink reload interface with the "fw_activate"
> action. This allows userspace to request activation of firmware without a
> reboot.
> 
> Note that support for indicating the required reset and EMP reset restriction is
> not supported on old versions of firmware. The driver can determine if the two
> features are supported by checking the device capabilities report. I confirmed
> support has existed since at least version 5.5.2 as reported by the 'fw.mgmt'
> version. Support to issue the EMP reset request has existed in all version of the
> EMP firmware for the ice hardware.
> 
> Check the device capabilities report to determine whether or not the
> indications are reported by the running firmware. If the reset requirement
> indication is not supported, always assume a full power on is necessary. If the
> reset restriction capability is not supported, always assume the EMP reset is
> available.
> 
> Users can verify if the EMP reset has activated the firmware by using the
> devlink info report to check that the 'running' firmware version has updated.
> For example a user might do the following:
> 
>  # Check current version
>  $ devlink dev info
> 
>  # Update the device
>  $ devlink dev flash pci/0000:af:00.0 file firmware.bin
> 
>  # Confirm stored version updated
>  $ devlink dev info
> 
>  # Reload to activate new firmware
>  $ devlink dev reload pci/0000:af:00.0 action fw_activate
> 
>  # Confirm running version updated
>  $ devlink dev info
> 
> Finally, this change does *not* implement basic driver-only reload support. I
> did look into trying to do this. However, it requires significant refactor of how
> the ice driver probes and loads everything.
> The ice driver probe and allocation flows were not designed with such a reload
> in mind. Refactoring the flow to support this is beyond the scope of this change.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Changes since v6
> * none
> 
> Changes since v5
> * Added a new patch that reduces the reset (and probe!) time
> * Reduced the maximum timeout of reload_up to 1 minute. This is probably
>   still a bit overkill in terms of total wait but ensures we wait long
>   enough for cases where multiple PFs rebuild flows are serialized due to
>   locks
> * Improved the error message when reset times out.
> 
> Changes since v4
> * completely re-write commit message for clarity
> * Update devlink ice.rst with documentation about reload
> * expand the terms "EMP" and "empr" for clarity
> * Rename the ice_devlink_reload_down to ice_devlink_reload_empr_start and
>   rename ice_devlink_reload_up to ice_devlink_reload_empr_finish. This is
>   done to clarify their functionality. It is also done because any future
>   support for devlink reload with driver reinit will want to continue
>   re-using these functions to support firmware activation.
> * Increase the maximum wait time for EMP reset to complete to 2 minutes.
>   It turns out that in practice the reset might take a while (longer than
>   the original 20 seconds I had in v4 and earlier).
> * Move the clearing of fw_emp_reset_disabled into the ice_rebuild logic.
>   This ensures the flag is properly cleared even when the EMP reset was
>   caused by another physical function.
> * Add comments explaining the various reset levels that the firmware can
>   report.
> 
> Changes since v3
> * correctly read response of NVM write activate from synchronous reply value
>   instead of from the ARQ event. This fixes a bug where we never reported
>   that EMP reset is available.
> 
> Changes since v2
> * ensure DEVLINK_F_RELOAD gets set
> * rebase to avoid conflicts
> 
>  Documentation/networking/devlink/ice.rst      |  24 ++-
>  drivers/net/ethernet/intel/ice/ice.h          |   1 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   7 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |  12 ++
>  drivers/net/ethernet/intel/ice/ice_devlink.c  |  99 ++++++++++
>  .../net/ethernet/intel/ice/ice_fw_update.c    | 181 +++++++++++++++---
>  .../net/ethernet/intel/ice/ice_fw_update.h    |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |   8 +
>  drivers/net/ethernet/intel/ice/ice_nvm.c      |  19 +-
>  drivers/net/ethernet/intel/ice/ice_nvm.h      |   2 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>  11 files changed, 330 insertions(+), 29 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
