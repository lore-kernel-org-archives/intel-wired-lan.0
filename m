From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 07 Mar 2016 09:29:51 -0800
Subject: [Intel-wired-lan] [PATCH 0/5] Bulk Tx cleanup support for Intel
	wired Ethernet drivers
Message-ID: <20160307172722.5682.38580.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series enables bulk Tx cleanup in NAPI context for i40e, i40evf,
ixgbe, ixgbevf, igb, and fm10k.  The igbvf driver has been excluded since
it does the cleanup in interrupt context so it cannot make use of the NAPI
cleanup routine.

In addition I fixed the i40e/i40evf bug that would cause us to stop
cleaning frames if one of the Tx cleanup routines reported a false.  This
should help to prevent any possible Tx hangs should multiple Tx queues be
assigned to a single interrupt vector.

---

Alexander Duyck (5):
      i40e/i40evf: Fix handling of boolean logic in polling routines
      i40e/i40evf: Add support for bulk free in Tx cleanup
      ixgbe/ixgbevf: Add support for bulk free in Tx cleanup & cleanup boolean logic
      fm10k: Add support for bulk Tx cleanup & cleanup boolean logic
      igb: Add support for bulk Tx cleanup & cleanup boolean logic


 drivers/net/ethernet/intel/fm10k/fm10k_main.c     |   14 ++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       |   31 ++++++++++++---------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c     |   31 ++++++++++++---------
 drivers/net/ethernet/intel/igb/igb_main.c         |   12 +++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   10 +++++--
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   14 ++++++---
 6 files changed, 68 insertions(+), 44 deletions(-)

--
