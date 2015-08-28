From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 28 Aug 2015 17:55:46 -0400
Subject: [Intel-wired-lan] [next PATCH S13 00/15] i40e/i40evf updates
Message-ID: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Catherine fixes check_tx_hang, which was missing an else statement.

Greg adds support for a FW CEE DCB nibble swap.

Jesse cleans up some code, refactors code to remove indent, adds a print
to show vxlan support at init, and fixes ip-ip GRE encapulation.

Mitch adds code to detect resets more reliably, changes i40evf to use
capabilities flags properly, and adds code to pass QOS handle to VF.

Shannon adds handling of the writeback descriptor, adds the GetStatus command
for nvmupdate, adds wait states to NVM state machine, adds exec_aq command to
nvmupdate utility, and adds get AQ result command to nvmupdate utility.

 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |  19 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         |  13 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |   1 +
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     | 124 +++++----
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c        |   1 -
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c     |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 162 +++++++-----
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         | 276 +++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   1 +
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  19 +-
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c    |   6 +-
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |   8 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |   8 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |   1 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |  10 +-
 drivers/net/ethernet/intel/i40evf/i40evf.h         |   5 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  48 ++--
 22 files changed, 531 insertions(+), 205 deletions(-)

-- 
1.9.3

