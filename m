From: Shiraz Saleem <shiraz.saleem@intel.com>
Date: Mon,  2 Mar 2020 10:51:58 -0600
Subject: [Intel-wired-lan] [PATCH RFC 00/16] Add Intel Ethernet Protocol
 Driver for RDMA (irdma)
Message-ID: <20200302165214.1143-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Shiraz, Saleem" <shiraz.saleem@intel.com>

This patchset adds a unified Intel Ethernet Protocol Driver for RDMA
that supports a new network device E810 (iWARP and RoCEv2 capable)
and the existing X722 iWARP device. The driver architecture
provides the extensibility for future generations of Intel HW
supporting RDMA.

This driver replaces the legacy X722 driver i40iw and extends
the ABI already defined for i40iw. It is backward compatible
with legacy X722 rdma-core provider (libi40iw).

This series was built against the rdma for-next branch.

v4-->v5:
*Drop driver_data usage from virtbus device id. Use string id
match to identify virtbus device type.
*Rename device discovery functions
*Drop rdma_set_device_sysfs_group API usage
*READ_ONCE annotations for netdev flags in rcu_read_lock 

v4:
*Remove redundant explicit casts
*Scrub all WQs to define correct charateristics and use system WQ for reset recovery work
*Remove all non-functional NULL checks on IDC peer dev OPs
*Change all pr_* to dev_* if struct device present. Remove dev_info logging
*Dont use test_bit on non-atomic IIDC_* event types
*Remove all module parameters
*Use bool bitfields in structures instead of bool
*Change CQP completion handling from kthread to WQ
*Use the generic devlink parameter enable_roce instead of driver specific one
*Use meaningful labels for goto unwind
*Use new RDMA mmap API
*Use refcount_t APIs for refcounts on driver objects
*Add support for ibdev OP dealloc_driver
*Adapt to use new version of virtbus
*Remove RCU locking in CM address resolve
*Misc. driver fixes

Michael J. Ruhl (1):
  RDMA/irdma: Add dynamic tracing for CM

Mustafa Ismail (13):
  RDMA/irdma: Add driver framework definitions
  RDMA/irdma: Implement device initialization definitions
  RDMA/irdma: Implement HW Admin Queue OPs
  RDMA/irdma: Add HMC backing store setup functions
  RDMA/irdma: Add privileged UDA queue implementation
  RDMA/irdma: Add QoS definitions
  RDMA/irdma: Add connection manager
  RDMA/irdma: Add PBLE resource manager
  RDMA/irdma: Implement device supported verb APIs
  RDMA/irdma: Add RoCEv2 UD OP support
  RDMA/irdma: Add user/kernel shared libraries
  RDMA/irdma: Add miscellaneous utility definitions
  RDMA/irdma: Add ABI definitions

Shiraz Saleem (2):
  RDMA/irdma: Add irdma Kconfig/Makefile and remove i40iw
  RDMA/irdma: Update MAINTAINERS file

 Documentation/ABI/stable/sysfs-class-infiniband |   18 -
 MAINTAINERS                                     |    8 +-
 drivers/infiniband/Kconfig                      |    2 +-
 drivers/infiniband/hw/Makefile                  |    2 +-
 drivers/infiniband/hw/i40iw/Kconfig             |    9 -
 drivers/infiniband/hw/i40iw/Makefile            |    9 -
 drivers/infiniband/hw/i40iw/i40iw.h             |  602 ---
 drivers/infiniband/hw/i40iw/i40iw_cm.c          | 4422 -----------------
 drivers/infiniband/hw/i40iw/i40iw_cm.h          |  462 --
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c        | 5198 --------------------
 drivers/infiniband/hw/i40iw/i40iw_d.h           | 1737 -------
 drivers/infiniband/hw/i40iw/i40iw_hmc.c         |  821 ----
 drivers/infiniband/hw/i40iw/i40iw_hmc.h         |  241 -
 drivers/infiniband/hw/i40iw/i40iw_hw.c          |  852 ----
 drivers/infiniband/hw/i40iw/i40iw_main.c        | 2064 --------
 drivers/infiniband/hw/i40iw/i40iw_osdep.h       |  217 -
 drivers/infiniband/hw/i40iw/i40iw_p.h           |  128 -
 drivers/infiniband/hw/i40iw/i40iw_pble.c        |  612 ---
 drivers/infiniband/hw/i40iw/i40iw_pble.h        |  131 -
 drivers/infiniband/hw/i40iw/i40iw_puda.c        | 1493 ------
 drivers/infiniband/hw/i40iw/i40iw_puda.h        |  188 -
 drivers/infiniband/hw/i40iw/i40iw_register.h    | 1030 ----
 drivers/infiniband/hw/i40iw/i40iw_status.h      |  101 -
 drivers/infiniband/hw/i40iw/i40iw_type.h        | 1363 ------
 drivers/infiniband/hw/i40iw/i40iw_uk.c          | 1232 -----
 drivers/infiniband/hw/i40iw/i40iw_user.h        |  430 --
 drivers/infiniband/hw/i40iw/i40iw_utils.c       | 1557 ------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c       | 2789 -----------
 drivers/infiniband/hw/i40iw/i40iw_verbs.h       |  179 -
 drivers/infiniband/hw/i40iw/i40iw_vf.c          |   85 -
 drivers/infiniband/hw/i40iw/i40iw_vf.h          |   62 -
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c    |  756 ---
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.h    |  124 -
 drivers/infiniband/hw/irdma/Kconfig             |   11 +
 drivers/infiniband/hw/irdma/Makefile            |   28 +
 drivers/infiniband/hw/irdma/cm.c                | 4499 +++++++++++++++++
 drivers/infiniband/hw/irdma/cm.h                |  413 ++
 drivers/infiniband/hw/irdma/ctrl.c              | 5985 +++++++++++++++++++++++
 drivers/infiniband/hw/irdma/defs.h              | 2132 ++++++++
 drivers/infiniband/hw/irdma/hmc.c               |  705 +++
 drivers/infiniband/hw/irdma/hmc.h               |  217 +
 drivers/infiniband/hw/irdma/hw.c                | 2597 ++++++++++
 drivers/infiniband/hw/irdma/i40iw_hw.c          |  211 +
 drivers/infiniband/hw/irdma/i40iw_hw.h          |  162 +
 drivers/infiniband/hw/irdma/i40iw_if.c          |  228 +
 drivers/infiniband/hw/irdma/icrdma_hw.c         |   76 +
 drivers/infiniband/hw/irdma/icrdma_hw.h         |   62 +
 drivers/infiniband/hw/irdma/irdma.h             |  190 +
 drivers/infiniband/hw/irdma/irdma_if.c          |  449 ++
 drivers/infiniband/hw/irdma/main.c              |  575 +++
 drivers/infiniband/hw/irdma/main.h              |  599 +++
 drivers/infiniband/hw/irdma/osdep.h             |  105 +
 drivers/infiniband/hw/irdma/pble.c              |  510 ++
 drivers/infiniband/hw/irdma/pble.h              |  135 +
 drivers/infiniband/hw/irdma/protos.h            |   93 +
 drivers/infiniband/hw/irdma/puda.c              | 1690 +++++++
 drivers/infiniband/hw/irdma/puda.h              |  186 +
 drivers/infiniband/hw/irdma/status.h            |   69 +
 drivers/infiniband/hw/irdma/trace.c             |  112 +
 drivers/infiniband/hw/irdma/trace.h             |    3 +
 drivers/infiniband/hw/irdma/trace_cm.h          |  458 ++
 drivers/infiniband/hw/irdma/type.h              | 1714 +++++++
 drivers/infiniband/hw/irdma/uda.c               |  390 ++
 drivers/infiniband/hw/irdma/uda.h               |   64 +
 drivers/infiniband/hw/irdma/uda_d.h             |  382 ++
 drivers/infiniband/hw/irdma/uk.c                | 1744 +++++++
 drivers/infiniband/hw/irdma/user.h              |  448 ++
 drivers/infiniband/hw/irdma/utils.c             | 2445 +++++++++
 drivers/infiniband/hw/irdma/verbs.c             | 4555 +++++++++++++++++
 drivers/infiniband/hw/irdma/verbs.h             |  213 +
 drivers/infiniband/hw/irdma/ws.c                |  395 ++
 drivers/infiniband/hw/irdma/ws.h                |   39 +
 include/uapi/rdma/i40iw-abi.h                   |  107 -
 include/uapi/rdma/ib_user_ioctl_verbs.h         |    1 +
 include/uapi/rdma/irdma-abi.h                   |  140 +
 75 files changed, 35036 insertions(+), 29025 deletions(-)
 delete mode 100644 drivers/infiniband/hw/i40iw/Kconfig
 delete mode 100644 drivers/infiniband/hw/i40iw/Makefile
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_cm.c
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_cm.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_ctrl.c
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_d.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_hmc.c
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_hmc.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_hw.c
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_main.c
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_osdep.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_p.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_pble.c
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_pble.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_puda.c
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_puda.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_register.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_status.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_type.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_uk.c
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_user.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_utils.c
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_verbs.c
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_verbs.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_vf.c
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_vf.h
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c
 delete mode 100644 drivers/infiniband/hw/i40iw/i40iw_virtchnl.h
 create mode 100644 drivers/infiniband/hw/irdma/Kconfig
 create mode 100644 drivers/infiniband/hw/irdma/Makefile
 create mode 100644 drivers/infiniband/hw/irdma/cm.c
 create mode 100644 drivers/infiniband/hw/irdma/cm.h
 create mode 100644 drivers/infiniband/hw/irdma/ctrl.c
 create mode 100644 drivers/infiniband/hw/irdma/defs.h
 create mode 100644 drivers/infiniband/hw/irdma/hmc.c
 create mode 100644 drivers/infiniband/hw/irdma/hmc.h
 create mode 100644 drivers/infiniband/hw/irdma/hw.c
 create mode 100644 drivers/infiniband/hw/irdma/i40iw_hw.c
 create mode 100644 drivers/infiniband/hw/irdma/i40iw_hw.h
 create mode 100644 drivers/infiniband/hw/irdma/i40iw_if.c
 create mode 100644 drivers/infiniband/hw/irdma/icrdma_hw.c
 create mode 100644 drivers/infiniband/hw/irdma/icrdma_hw.h
 create mode 100644 drivers/infiniband/hw/irdma/irdma.h
 create mode 100644 drivers/infiniband/hw/irdma/irdma_if.c
 create mode 100644 drivers/infiniband/hw/irdma/main.c
 create mode 100644 drivers/infiniband/hw/irdma/main.h
 create mode 100644 drivers/infiniband/hw/irdma/osdep.h
 create mode 100644 drivers/infiniband/hw/irdma/pble.c
 create mode 100644 drivers/infiniband/hw/irdma/pble.h
 create mode 100644 drivers/infiniband/hw/irdma/protos.h
 create mode 100644 drivers/infiniband/hw/irdma/puda.c
 create mode 100644 drivers/infiniband/hw/irdma/puda.h
 create mode 100644 drivers/infiniband/hw/irdma/status.h
 create mode 100644 drivers/infiniband/hw/irdma/trace.c
 create mode 100644 drivers/infiniband/hw/irdma/trace.h
 create mode 100644 drivers/infiniband/hw/irdma/trace_cm.h
 create mode 100644 drivers/infiniband/hw/irdma/type.h
 create mode 100644 drivers/infiniband/hw/irdma/uda.c
 create mode 100644 drivers/infiniband/hw/irdma/uda.h
 create mode 100644 drivers/infiniband/hw/irdma/uda_d.h
 create mode 100644 drivers/infiniband/hw/irdma/uk.c
 create mode 100644 drivers/infiniband/hw/irdma/user.h
 create mode 100644 drivers/infiniband/hw/irdma/utils.c
 create mode 100644 drivers/infiniband/hw/irdma/verbs.c
 create mode 100644 drivers/infiniband/hw/irdma/verbs.h
 create mode 100644 drivers/infiniband/hw/irdma/ws.c
 create mode 100644 drivers/infiniband/hw/irdma/ws.h
 delete mode 100644 include/uapi/rdma/i40iw-abi.h
 create mode 100644 include/uapi/rdma/irdma-abi.h

-- 
1.8.3.1

