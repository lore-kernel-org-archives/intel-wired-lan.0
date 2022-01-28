From: Alan Brady <alan.brady@intel.com>
Date: Thu, 27 Jan 2022 16:09:50 -0800
Subject: [Intel-wired-lan] [PATCH net-next 00/19] Add iecm and idpf
Message-ID: <20220128001009.721392-1-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series introduces both the Intel Ethernet Common Module and the
Intel Data Plane Function.  This also adds extended features and
functionality to virtchnl with virtchnl_2.h.
 
The format of the series generally follows the flow of driver init to
interface open. We go from probe into a hard reset followed by an init
task. From there the rest of the netdev_ops and data path are added.
Then lastly advanced features and idpf are introduced.

Currently this common layer (iecm) is initially only being used by only
the idpf driver (PF driver for SmartNIC).  However, the plan is to
eventually switch our iavf driver along with future drivers to use this
common module.  The hope is to better enable code sharing going forward
as well as support other developers writing drivers for our hardware

Alan Brady (17):
  virtchnl: Add new virtchnl2 ops
  iecm: add basic module init and documentation
  iecm: add probe and remove
  iecm: add api_init and controlq init
  iecm: add vport alloc and virtchnl messages
  iecm: add virtchnl messages for queues
  iecm: finish virtchnl messages
  iecm: add interrupts and configure netdev
  iecm: alloc vport TX resources
  iecm: alloc vport RX resources
  iecm: add start_xmit and set_rx_mode
  iecm: finish netdev_ops
  iecm: implement splitq napi_poll
  iecm: implement singleq napi_poll
  iecm: implement ethtool callbacks
  iecm: implement cloud filters
  idpf: introduce idpf driver

Haiyue Wang (2):
  iecm: implement flow director
  iecm: add advanced rss

 .../device_drivers/ethernet/intel/idpf.rst    |   47 +
 .../device_drivers/ethernet/intel/iecm.rst    |   93 +
 MAINTAINERS                                   |    1 +
 drivers/net/ethernet/intel/Kconfig            |   31 +
 drivers/net/ethernet/intel/Makefile           |    2 +
 drivers/net/ethernet/intel/idpf/Makefile      |   15 +
 drivers/net/ethernet/intel/idpf/idpf_dev.h    |   17 +
 drivers/net/ethernet/intel/idpf/idpf_devids.h |   10 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  140 +
 drivers/net/ethernet/intel/idpf/idpf_reg.c    |  130 +
 drivers/net/ethernet/intel/iecm/Makefile      |   21 +
 .../net/ethernet/intel/iecm/iecm_controlq.c   |  649 ++
 .../ethernet/intel/iecm/iecm_controlq_setup.c |  175 +
 .../net/ethernet/intel/iecm/iecm_ethtool.c    | 1332 ++++
 drivers/net/ethernet/intel/iecm/iecm_lib.c    | 5717 +++++++++++++++++
 drivers/net/ethernet/intel/iecm/iecm_main.c   |   40 +
 .../ethernet/intel/iecm/iecm_singleq_txrx.c   | 1229 ++++
 drivers/net/ethernet/intel/iecm/iecm_txrx.c   | 4577 +++++++++++++
 .../net/ethernet/intel/iecm/iecm_virtchnl.c   | 4240 ++++++++++++
 drivers/net/ethernet/intel/include/iecm.h     |  973 +++
 .../ethernet/intel/include/iecm_controlq.h    |  117 +
 .../intel/include/iecm_controlq_api.h         |  185 +
 .../ethernet/intel/include/iecm_lan_pf_regs.h |  131 +
 .../ethernet/intel/include/iecm_lan_txrx.h    |  394 ++
 drivers/net/ethernet/intel/include/iecm_mem.h |   20 +
 .../net/ethernet/intel/include/iecm_txrx.h    |  733 +++
 include/linux/avf/virtchnl.h                  | 1507 ++++-
 include/linux/avf/virtchnl_2.h                | 1243 ++++
 include/linux/avf/virtchnl_lan_desc.h         |  603 ++
 29 files changed, 24255 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/idpf.rst
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/iecm.rst
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
 create mode 100644 drivers/net/ethernet/intel/iecm/iecm_singleq_txrx.c
 create mode 100644 drivers/net/ethernet/intel/iecm/iecm_txrx.c
 create mode 100644 drivers/net/ethernet/intel/iecm/iecm_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/include/iecm.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_controlq.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_controlq_api.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_lan_pf_regs.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_lan_txrx.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_mem.h
 create mode 100644 drivers/net/ethernet/intel/include/iecm_txrx.h
 create mode 100644 include/linux/avf/virtchnl_2.h
 create mode 100644 include/linux/avf/virtchnl_lan_desc.h

-- 
2.33.0

