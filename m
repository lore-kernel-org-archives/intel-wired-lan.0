From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Feb 2022 16:26:47 -0800
Subject: [Intel-wired-lan] [net-next PATCH 00/25] ice: reorganize
 virtualization code
Message-ID: <20220223002712.2771809-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ice_virtchnl_pf.c file has become a single place for a lot of
virtualization functionality. This includes most of the virtchnl message
handling, integration with kernel hooks like the .ndo operations, reset
logic, and more.

We are planning in the future to implement and support Scalable IOV in the
ice driver. To do this, much (but not all) of the code in ice_virtchnl_pf.c
will want to be reused.

Rather than dump all of the Scalable IOV implementation into
ice_virtchnl_pf.c it makes sense to house it in a separate file. But that
still leaves all of the Single Root IOV code littered among more generic
logic.

This series reorganizes code to make the non-implementation specific bits
into new files with the following general guidelines:

 * ice_vf_lib.[ch]

   Basic VF structures and accessors. This is where scheme-independent
   code will reside.

 * ice_virtchnl.[ch]

   Virtchnl message handling. This is where the bulk of the logic for
   processing messages from VFs using the virtchnl messaging scheme will
   reside. This is separated from ice_vf_lib.c because it is distinct
   and has a bulk of the processing code.

 * ice_sriov.[ch]

   Single Root IOV implementation, including initialization and the
   routines for interacting with SR-IOV based netdev operations.

 * (future) ice_siov.[ch]

   Scalable IOV implementation.

The goal is to make it easier to re-use parts of the virtualization logic
while separating concerns such as Single Root specific implementation
details.

In addition, this series has several minor cleanups and refactors we've
accumulated during this development cycle which help prepare the ice driver
for the Scalable IOV implementation.

This series builds on top of the recent hash table refactor work.

Jacob Keller (25):
  ice: rename ice_sriov.c to ice_vf_mbx.c
  ice: rename ice_virtchnl_pf.c to ice_sriov.c
  ice: remove circular header dependencies on ice.h
  ice: convert vf->vc_ops to a const pointer
  ice: remmove unused definitions from ice_sriov.h
  ice: rename ICE_MAX_VF_COUNT to avoid confusion
  ice: refactor spoofchk control code in ice_sriov.c
  ice: move ice_set_vf_port_vlan near other .ndo ops
  ice: cleanup error logging for ice_ena_vfs
  ice: log an error message when eswitch fails to configure
  ice: use ice_is_vf_trusted helper function
  ice: introduce ice_vf_lib.c, ice_vf_lib.h, and ice_vf_lib_private.h
  ice: fix incorrect dev_dbg print mistaking 'i' for vf->vf_id
  ice: introduce VF operations structure for reset flows
  ice: fix a long line warning in ice_reset_vf
  ice: move reset functionality into ice_vf_lib.c
  ice: drop is_vflr parameter from ice_reset_all_vfs
  ice: make ice_reset_all_vfs void
  ice: convert ice_reset_vf to standard error codes
  ice: convert ice_reset_vf to take flags
  ice: introduce ICE_VF_RESET_NOTIFY flag
  ice: introduce ICE_VF_RESET_LOCK flag
  ice: cleanup long longs in ice_sriov.c
  ice: introduce ice_virtchnl.c and ice_virtchnl.h
  ice: remove PF pointer from ice_check_vf_init

 drivers/net/ethernet/intel/ice/Makefile       |    6 +-
 drivers/net/ethernet/intel/ice/ice.h          |    5 +-
 drivers/net/ethernet/intel/ice/ice_arfs.h     |    3 +
 drivers/net/ethernet/intel/ice/ice_base.c     |    2 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    4 +-
 drivers/net/ethernet/intel/ice/ice_dcb.h      |    1 +
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |    1 +
 drivers/net/ethernet/intel/ice/ice_flow.c     |    1 +
 drivers/net/ethernet/intel/ice/ice_flow.h     |    2 +
 drivers/net/ethernet/intel/ice/ice_idc_int.h  |    1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |   25 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h    |   11 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     |    6 +-
 drivers/net/ethernet/intel/ice/ice_repr.h     |    1 -
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 2305 ++++++++++---
 drivers/net/ethernet/intel/ice/ice_sriov.h    |  165 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |    1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 1029 ++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  290 ++
 .../ethernet/intel/ice/ice_vf_lib_private.h   |   40 +
 .../intel/ice/{ice_sriov.c => ice_vf_mbx.c}   |    2 +-
 .../intel/ice/{ice_sriov.h => ice_vf_mbx.h}   |    6 +-
 .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c  |    2 +-
 .../ice/{ice_virtchnl_pf.c => ice_virtchnl.c} | 3002 +----------------
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   82 +
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |    1 +
 .../ethernet/intel/ice/ice_virtchnl_fdir.h    |    1 +
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  437 ---
 drivers/net/ethernet/intel/ice/ice_xsk.h      |    1 -
 29 files changed, 3566 insertions(+), 3867 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_vf_lib.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_vf_lib.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
 copy drivers/net/ethernet/intel/ice/{ice_sriov.c => ice_vf_mbx.c} (99%)
 copy drivers/net/ethernet/intel/ice/{ice_sriov.h => ice_vf_mbx.h} (95%)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl_pf.c => ice_virtchnl.c} (57%)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl.h
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h


base-commit: 81003a1453e724321ed9cc9f75fb92d74884c413
prerequisite-patch-id: 9685201f53a380b760fafc19ce4c52503dce7b0f
-- 
2.35.1.129.gb80121027d12

