From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Fri, 20 Jul 2018 18:29:24 -0400
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 0/2] Address issues
 with reset on systems with high completion timeout times
Message-ID: <20180720222647.3568.34992.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series is meant to address issues seen with ixgbe on systems
with high completion timeout times. Specifically the Tx and Rx queue
disable functions are supposed to poll until the enable bit is actually
cleared, and isntead of doing that we were failing immediately after just
100us in the case of Rx and weren't bothering to test in the case of Tx.
Instead this patch set adds polling logic with the upper bounds defined
using the intervals defined in the completion timeout logic.

In addition I have reorganized the code to parallelize this as much as
possible so that the Tx and Rx should hopefully flush out at around the
same time so we only experience on wait for all of the queues instead of
waiting per queue.

---

Alexander Duyck (2):
      ixgbe: Reorder Tx/Rx shutdown to reduce time needed to stop device
      ixgbe: Refactor queue disable logic to take completion time into account


 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   32 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  290 +++++++++++++++++-----
 3 files changed, 229 insertions(+), 96 deletions(-)

--
