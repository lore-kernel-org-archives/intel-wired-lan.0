From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 11 Apr 2022 16:29:01 -0700
Subject: [Intel-wired-lan] [PATCH net-next 0/6] minor cleanups for ice
 virtualization
Message-ID: <20220411232907.1022602-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series contains a few minor fix ups for virtualization files. Mainly
this includes fixes for function header comments and minor wording changes.

The only larger change is a patch which adds NULL checks to ice_get_vf_vsi.
This was done in order to prevent static analysis tools from complaining
that a NULL value could be dereferenced. Flows where an error is not
feasible have a WARN_ON check added. This change enhances the robustness of
the driver by avoiding a panic in the event that a VF does not have a valid
VSI.

Jacob Keller (6):
  ice: add newline to dev_dbg in ice_vf_fdir_dump_info
  ice: always check VF VSI pointer values
  ice: remove return value comment for ice_reset_all_vfs
  ice: fix wording in comment for ice_reset_vf
  ice: add a function comment for ice_cfg_mac_antispoof
  ice: remove period on argument description in ice_for_each_vf

 drivers/net/ethernet/intel/ice/ice_devlink.c  |  5 ++-
 drivers/net/ethernet/intel/ice/ice_repr.c     |  7 ++-
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 32 ++++++++++++--
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 43 ++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  4 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  5 +++
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  9 +++-
 7 files changed, 91 insertions(+), 14 deletions(-)


base-commit: c3ac33fdeac6d1a23f2d28aafaee5520632c159f
-- 
2.35.1.456.ga9c7032d4631

