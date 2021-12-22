From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Wed, 22 Dec 2021 07:21:58 +0100
Subject: [Intel-wired-lan] [PATCH net-next 0/3] refactor irq allocation in
 ice
Message-ID: <20211222062201.36302-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ice driver uses the old PCI irq reseveration API. Change the ice
driver to use the current API.

Implement a fallback mechanism where, if the driver can't reserve the
maximum number of interrupts, it will limit the number of queues or
disable capabilities.

First two patches add ability to turn on and off eswitch offload. This
is needed when driver can't reserve maximum number of interrupts. In
this case driver turns off eswitch offload as driver can work
without it. Additionally, the eswitch can be supported only if SRIOV is
available, so set eswitch capabilities only if SRIOV is supported.

Michal Swiatkowski (3):
  ice: add check for eswitch support
  ice: change mode only if eswitch is supported
  ice: use new alloc irqs API

 drivers/net/ethernet/intel/ice/Makefile      |   3 +-
 drivers/net/ethernet/intel/ice/ice.h         |   4 +-
 drivers/net/ethernet/intel/ice/ice_arfs.c    |   3 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  46 +++-
 drivers/net/ethernet/intel/ice/ice_eswitch.h |  12 +
 drivers/net/ethernet/intel/ice/ice_irq.c     | 213 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_irq.h     |  12 +
 drivers/net/ethernet/intel/ice/ice_lib.c     |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c    | 220 +------------------
 drivers/net/ethernet/intel/ice/ice_xsk.c     |   3 +-
 10 files changed, 300 insertions(+), 221 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_irq.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_irq.h

-- 
2.31.1

