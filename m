From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Tue, 22 Dec 2015 14:25:02 -0800
Subject: [Intel-wired-lan] [next PATCH S24 00/12] i40e/i40evf updates
Message-ID: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali Singhai Jain adds new device IDs for X722, extends ethtool RSS hooks 
for X722, adds a fix for UDP/TCP RSS for X722, X722 changes to access nvm, 
and new write-back mode.

Catherine Sullivan adds 100Mb ethtool reporting.

Greg Bowers limits DCB FW version checks to X710/XL710 devices.

Jesse Brandeburg adds use of private workqueue.

Shannon Nelson adds new proxy-wol bits for X722_SUPPORT, implements
'AQ add Run PHY Activity struct', 'AQ Geneve cloud tunnel type', and
'AQ add external power class to get link status'.

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 25 +++++++-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  2 +
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         | 12 ++--
 drivers/net/ethernet/intel/i40e/i40e_devids.h      |  2 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 22 +++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 73 +++++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         | 49 +++++++++------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 ++++
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 25 +++++++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 16 +++++
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 29 +++++++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 23 +++++--
 12 files changed, 249 insertions(+), 41 deletions(-)

-- 
2.1.0

