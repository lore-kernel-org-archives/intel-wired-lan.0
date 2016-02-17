From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 17 Feb 2016 11:02:37 -0800
Subject: [Intel-wired-lan] [next PATCH 0/4] i40e/i40evf: Improve throughput
 by reducing PCIe overhead
Message-ID: <20160217185838.10339.68543.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series is meant to address some minor performance issues and to
improve the throughput for the adapter.

On my system I saw a .5Gbps improvement based on these patches.

Specific items addressed include the use of modulo division in the Tx
fast-path, redundant checks against CHECKSUM_PARTIAL, and the use of only
8K of data per TXD when the maximum supported value is 16K - 1.

---

Alexander Duyck (4):
      i40e/i40evf: Break up xmit_descriptor_count from maybe_stop_tx
      i40e/i40evf: Rewrite logic for 8 descriptor per packet check
      i40e/i40evf: Move Tx checksum closer to TSO
      i40e/i40evf: Allow up to 12K bytes of data per Tx descriptor instead of 8K


 drivers/net/ethernet/intel/i40e/i40e_fcoe.c   |   20 ++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  199 +++++++++++--------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   96 ++++++++++++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  190 +++++++++++-------------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h |   94 ++++++++++++
 5 files changed, 374 insertions(+), 225 deletions(-)

--
