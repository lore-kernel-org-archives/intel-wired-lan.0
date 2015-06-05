From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri,  5 Jun 2015 12:20:24 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 00/10] Add
	X722 device support to i40e and i40evf
Message-ID: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali adds device ids, adds flags, updates the FW API, updates register.h,
makes necessary RSS changes, adds support for writeback on ITR, adds support
for TX/RX outer UDP checksum, adds IWARP support and adds ATR HW eviction
support for the new X722 device.

Shannon adds the necessary AQ commands for NVM Update for X722.

 drivers/net/ethernet/intel/i40e/i40e.h             |   15 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |   48 +
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  173 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  181 +-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  129 ++
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   11 +
 drivers/net/ethernet/intel/i40e/i40e_register.h    | 1931 +++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   72 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   16 +
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   39 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   11 +-
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |   49 +-
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |  172 ++
 drivers/net/ethernet/intel/i40evf/i40e_prototype.h |   11 +
 drivers/net/ethernet/intel/i40evf/i40e_register.h  |   62 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |   51 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |   16 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |   35 +-
 drivers/net/ethernet/intel/i40evf/i40evf.h         |    8 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  167 +-
 20 files changed, 3080 insertions(+), 117 deletions(-)

-- 
1.9.3

