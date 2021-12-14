From: Joe Damato <jdamato@fastly.com>
Date: Tue, 14 Dec 2021 14:42:05 -0800
Subject: [Intel-wired-lan] [net-queue PATCH 0/5] i40e: stat counter updates
 and additions
Message-ID: <1639521730-57226-1-git-send-email-jdamato@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Greetings:

This patch set makes several updates to the i40e driver stats collection
and reporting code to help users of i40e get a better sense of how the
driver is performing and interacting with the rest of the kernel.

These patches include some new stats (like waived and busy) which were
inspired by other drivers that track stats using the same nomenclature.

The new stats and an existing stat, rx_reuse, are now accessible with
ethtool to make harvesting this data more convenient for users.

Joe Damato (5):
  i40e: Remove rx page reuse double count.
  i40e: Aggregate and export RX page reuse stat.
  i40e: Add a stat tracking new RX page allocations.
  i40e: Add a stat for tracking pages waived.
  i40e: Add a stat for tracking busy rx pages.

 drivers/net/ethernet/intel/i40e/i40e.h         |  4 ++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  4 ++++
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 14 +++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 25 ++++++++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  3 +++
 5 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.7.4

