From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 15 Feb 2022 17:31:16 -0800
Subject: [Intel-wired-lan] [net-next PATCH 00/11] ice: convert VF storage to
 hash table
Message-ID: <20220216013127.3263153-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series refactors the ice networking driver VF storage from a simple
static array to a hash table. It also introduces krefs and proper locking
and protection to prevent common use-after-free and concurrency issues.

There are two motivations for this work. First is to make the ice driver
more resilient by preventing a whole class of use-after-free bugs that can
occur around concurrent access to VF structures while removing VFs.

The second is to prepare the ice driver for future virtualization work to
support Scalable IOV, an alternative VF implementation compared to Single
Root IOV. The new VF implementation will allow for more dynamic VF creation
and removal, necessitating a more robust implementation for VF storage that
can't rely on the existing mechanisms to prevent concurrent access
violations.

The first few patches are cleanup and preparatory work needed to make the
conversion to the hash table safe. Following this preparatory work is a
patch to migrate the VF structures and variables to a new sub-structure for
code clarity. Next introduce new interface functions to abstract the VF
storage. Finally, the driver is actually converted to the hash table and
kref implementation.

Jacob Keller (11):
  ice: refactor unwind cleanup in eswitch mode
  ice: store VF pointer instead of VF ID
  ice: pass num_vfs to ice_set_per_vf_res()
  ice: move clear_malvf call in ice_free_vfs
  ice: move VFLR acknowledge during ice_free_vfs
  ice: remove checks in ice_vc_send_msg_to_vf
  ice: use ice_for_each_vf for iteration during removal
  ice: convert ice_for_each_vf to include VF entry iterator
  ice: factor VF variables to separate structure
  ice: introduce VF accessor functions
  ice: convert VF storage to hash table with krefs and RCU

 drivers/net/ethernet/intel/ice/ice.h          |  13 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 161 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  20 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 203 +++--
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  64 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     |  70 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c  |  19 +-
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  13 +-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 784 +++++++++++-------
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  83 +-
 13 files changed, 879 insertions(+), 560 deletions(-)


base-commit: 477606a501d0705cb1bb86fe7aa86f553861ae7f
-- 
2.35.1.129.gb80121027d12

