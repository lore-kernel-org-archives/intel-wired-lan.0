From: Alice Michael <alice.michael@intel.com>
Date: Thu, 14 May 2020 23:34:46 -0700
Subject: [Intel-wired-lan] [iecm/idpf V1 00/14] iecm/idpf series cover letter
Message-ID: <20200515063500.48301-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series introduces both the Intel Ethernet Common
Module and the Intel Data Plane Function.  The patches
also incorporate extended features and functionality
added in the virtchnl.h file.

The format of the series flow is to add the data set,
then introduce function stubs, and then introduce pieces
in large cohesive subjects or functionality.  This is to
allow for more in depth understanding and review of the
bigger picture as the series is reviewed.

Patch 13 adds the common module to the kernel build system,
and patch 14 adds the idpf driver which utilizes the common
module.

Patches:
  idpf: Introduce idpf driver
  iecm: Add framework set of header files
  iecm: Add TX/RX header files
  iecm: Common module introduction and function stubs
  iecm: Add basic netdevice functionality
  iecm: Implement mailbox functionality
  iecm: Implement virtchnl commands
  iecm: Implement vector allocation
  iecm: Init and allocate vport
  iecm: Deinit vport
  iecm: Add splitq TX/RX
  iecm: Add singleq TX/RX
  iecm: Add ethtool
  iecm: Add iecm to the kernel build system

Work done by:
  Signed-off-by: Alice Michael <alice.michael@intel.com>
  Signed-off-by: Alan Brady <Alan.Brady@intel.com>
  Signed-off-by: Phani Burra <phani.r.burra@intel.com>
  Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
  Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
  Signed-off-by: Pavan Kumar Linga <Pavan.Kumar.Linga@intel.com>
  Reviewed-by: Donald Skidmore <donald.c.skidmore@intel.com>
  Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
  Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

 .../networking/device_drivers/intel/idpf.rst  |   47 +
 .../networking/device_drivers/intel/iecm.rst  |   91 +
 MAINTAINERS                                   |    2 +
 drivers/net/ethernet/intel/Kconfig            |   15 +
 drivers/net/ethernet/intel/Makefile           |    2 +
 drivers/net/ethernet/intel/idpf/Makefile      |   14 +
 drivers/net/ethernet/intel/idpf/idpf_dev.h    |   18 +
 drivers/net/ethernet/intel/idpf/idpf_devids.h |   10 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  139 +
 drivers/net/ethernet/intel/idpf/idpf_reg.c    |  152 +
 drivers/net/ethernet/intel/iecm/Makefile      |   21 +
 .../net/ethernet/intel/iecm/iecm_controlq.c   |  673 +++
 .../ethernet/intel/iecm/iecm_controlq_setup.c |  177 +
 .../net/ethernet/intel/iecm/iecm_ethtool.c    | 1119 +++++
 drivers/net/ethernet/intel/iecm/iecm_lib.c    | 1092 +++++
 drivers/net/ethernet/intel/iecm/iecm_main.c   |   51 +
 drivers/net/ethernet/intel/iecm/iecm_osdep.c  |   28 +
 .../ethernet/intel/iecm/iecm_singleq_txrx.c   |  890 ++++
 drivers/net/ethernet/intel/iecm/iecm_txrx.c   | 3959 +++++++++++++++++
 .../net/ethernet/intel/iecm/iecm_virtchnl.c   | 2231 ++++++++++
 drivers/net/ethernet/intel/include/iecm.h     |  432 ++
 .../net/ethernet/intel/include/iecm_alloc.h   |   29 +
 .../ethernet/intel/include/iecm_controlq.h    |   95 +
 .../intel/include/iecm_controlq_api.h         |  223 +
 .../ethernet/intel/include/iecm_lan_pf_regs.h |  114 +
 .../ethernet/intel/include/iecm_lan_txrx.h    |  636 +++
 .../net/ethernet/intel/include/iecm_osdep.h   |   29 +
 .../net/ethernet/intel/include/iecm_txrx.h    |  610 +++
 .../net/ethernet/intel/include/iecm_type.h    |   47 +
 29 files changed, 12946 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/intel/idpf.rst
 create mode 100644 Documentation/networking/device_drivers/intel/iecm.rst
 create mode 100644 drivers/net/ethernet/intel/idpf/Makefile
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_dev.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devids.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_main.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_reg.c
 create mode 100644 drivers/net/ethernet/intel/iecm/Makefile
 create mode 100644 drivers/net/ethernet/intel/iecm/iecm_controlq.c
 create mode 100644 drivers/net/ethernet/intel/iecm/iecm_controlq_setup.c
 create mode 100644 drivers/net/ethernet/intel/iecm/iecm_ethtool.c
 create mode 100644 drivers/net/ethernet/intel/iecm/iecm_lib.c
 create mode 100644 drivers/net/ethernet/intel/iecm/iecm_main.c
 create mode 100644 drivers/net/ethernet/intel/iecm/iecm_osdep.c
 create mode 100644 drivers/net/ethernet/intel/iecm/iecm_singleq_txrx.c
 create mode 100644 drivers/net/ethernet/intel/iecm/iecm_txrx.c
 create mode 100644 drivers/net/ethernet/intel/iecm/iecm_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/include/iecm.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_alloc.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_controlq.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_controlq_api.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_lan_pf_regs.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_lan_txrx.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_osdep.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_txrx.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_type.h

-- 
2.21.0

