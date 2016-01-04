From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Mon,  4 Jan 2016 10:33:00 -0800
Subject: [Intel-wired-lan] [next PATCH S26 00/12] i40e/i40evf updates
Message-ID: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jacob Keller avoids large memcpy by assigning struct.

Jesse Brandeburg drops duplicate definition, fixes
missing space, fixes bug in dma sync, allocates
memory safely, fixes do not sleep in netdev_ops,
drops unused function, and counts allocation errors.

Kiran Patil adds APIs to add/remove port mirroring rules.

Shannon Nelson does TSO only if CHECKSUM_PARTIAL is set, and
negates phy int mask bits.

 drivers/net/ethernet/intel/i40e/i40e.h           |   1 -
 drivers/net/ethernet/intel/i40e/i40e_common.c    | 162 +++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c   |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |   2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c      |  53 +++-----
 drivers/net/ethernet/intel/i40e/i40e_prototype.h |  12 ++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c      |  11 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c    |  11 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c  |   2 +-
 9 files changed, 218 insertions(+), 44 deletions(-)

-- 
2.1.0

