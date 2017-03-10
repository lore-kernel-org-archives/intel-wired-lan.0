From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 10 Mar 2017 12:21:59 -0800
Subject: [Intel-wired-lan] [next PATCH S62 0/6] i40e/i40evf updates
Message-ID: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck adds code to clean up handling of private flags.

Christopher Bednarz adds code to check for new arq elements before 
leaving the adminq subtask loop.

Jacob Keller removes a useless goto statement & removes 
FDIR_REQUIRES_REINIT driver flag.

Paul M Stillwell adds code to use register for XL722 control register 
read/write.

Preethi Banala adds code to enforce descriptor write-back mechanism for 
VF.

 drivers/net/ethernet/intel/i40e/i40e.h             |   9 -
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 189 ++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  10 +-
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |   8 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  64 +------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  14 --
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |   4 -
 8 files changed, 135 insertions(+), 171 deletions(-)

-- 
2.4.11

