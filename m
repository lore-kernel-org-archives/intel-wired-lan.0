From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Sep 2016 14:18:36 -0700
Subject: [Intel-wired-lan] [next PATCH S46 0/8] i40e/i40evf updates
Message-ID: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Akeem Abodunrin adds code to increase minimum number of allocated VSI.

Alexander Duyck adds code to fix Flow Director raw_buf cleanup, adds
txring_txq function to match fm10k and ixgbe, splits Flow Director
descriptor config into separate functions & strips out debugfs hook
for Flow Director filter programming.

Jacob Keller adds code for queue-specific settings for interrupt 
moderation.

Mitch Williams enables adaptive interrupt throttling & adds code to not
configure zero-size RSS table.

 drivers/net/ethernet/intel/i40e/i40e.h             |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  80 --------
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  72 ++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 166 ++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   9 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  51 +++--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  17 ++
 drivers/net/ethernet/intel/i40evf/i40evf.h         |   7 -
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 206 ++++++++++++++++-----
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  14 +-
 11 files changed, 393 insertions(+), 235 deletions(-)

-- 
2.4.11

