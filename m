From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 12 Apr 2022 07:44:20 +0200
Subject: [Intel-wired-lan] [PATCH net-next 0/6] minor cleanups for ice
 virtualization
In-Reply-To: <20220411232907.1022602-1-jacob.e.keller@intel.com>
References: <20220411232907.1022602-1-jacob.e.keller@intel.com>
Message-ID: <4a3aca36-3dd4-51fb-660c-42adb306bd0e@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jacob,


Am 12.04.22 um 01:29 schrieb Jacob Keller:
> This series contains a few minor fix ups for virtualization files. Mainly
> this includes fixes for function header comments and minor wording changes.
> 
> The only larger change is a patch which adds NULL checks to ice_get_vf_vsi.
> This was done in order to prevent static analysis tools from complaining
> that a NULL value could be dereferenced. Flows where an error is not
> feasible have a WARN_ON check added. This change enhances the robustness of
> the driver by avoiding a panic in the event that a VF does not have a valid
> VSI.
> 
> Jacob Keller (6):
>    ice: add newline to dev_dbg in ice_vf_fdir_dump_info
>    ice: always check VF VSI pointer values
>    ice: remove return value comment for ice_reset_all_vfs
>    ice: fix wording in comment for ice_reset_vf
>    ice: add a function comment for ice_cfg_mac_antispoof
>    ice: remove period on argument description in ice_for_each_vf
> 
>   drivers/net/ethernet/intel/ice/ice_devlink.c  |  5 ++-
>   drivers/net/ethernet/intel/ice/ice_repr.c     |  7 ++-
>   drivers/net/ethernet/intel/ice/ice_sriov.c    | 32 ++++++++++++--
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 43 ++++++++++++++++---
>   drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  4 +-
>   drivers/net/ethernet/intel/ice/ice_virtchnl.c |  5 +++
>   .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  9 +++-
>   7 files changed, 91 insertions(+), 14 deletions(-)

Besides the nitpicks, the whole series looks good. Thank you very much 
for doing such cleanup work.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
