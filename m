From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  1 Jun 2017 15:40:36 -0700
Subject: [Intel-wired-lan] [PATCH 00/15] harden fm10k driver against PFLR
	and surprise remove
Message-ID: <20170601224051.6106-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series of patches is aimed primarily at resolving some issues seen
when the PCIe device is detached. Additionally some work was done to
allow better handling for large number of VLAN messages with many VFs.
These changes help stabilize the driver under surprise remove events and
avoid kernel panics.

The first few patches include general driver cleanup, such as removing
unnecessary latency for the first reset, and fixing some new warnings
found with GCC 7.

Next, we have some patches related to the handling of VFLRE events. The
code here was pretty weird, and caused some problems if the PF device
was reset while handling the VFLRE events.

There's a few patches which fix up some kernel panics and hard lockups
which can occur if the device is removed without notice (for example if
you perform a PFLR event without using the .reset_notify() logic).

Finally we have some patches aimed at stabilizing the driver when a
large number of VLAN updates occur. For example, if you create many VFs,
and add hundreds of VLANs per VF, previously the driver would enter into
a permanent reset loop, where it would send too many mailbox messages,
which causes the driver to mailbox timeout, reset, and then during reset
attempt to re-add all those same VLAN messages.

To resolve this, we added a somewhat complicated MAC/VLAN message queue.
This queue is important because it allows us to delay sending mailbox
messages until we have space. We originally tried some patches to simply
increase the mailbox size, but ultimately this solution was not
tractable and resulted in a lot of wasted memory.

The queue solution could theoretically be expanded to handle all mailbox
messages, but we determined through testing that only MAC address and
VLAN updates actually generated sufficient mailbox messages to actually
trigger these timeouts.

Jacob Keller (15):
  fm10k: stop spurious link down messages when Tx FIFO is full
  fm10k: fix typos on fall through comments
  fm10k: avoid possible truncation of q_vector->name
  fm10k: add missing fall through comment
  fm10k: avoid needless delay when loading driver
  fm10k: simplify reading PFVFLRE register
  fm10k: don't loop while resetting VFs due to VFLR event
  fm10k: avoid divide by zero in rare cases when device is resetting
  fm10k: move fm10k_prepare_for_reset and fm10k_handle_reset
  fm10k: prepare_for_reset() when we lose PCIe Link
  fm10k: prevent race condition of __FM10K_SERVICE_SCHED
  fm10k: use spinlock to implement mailbox lock
  fm10k: use generic PM hooks instead of legacy PCIe power hooks
  fm10k: introduce a message queue for MAC/VLAN messages
  fm10k: use the MAC/VLAN queue for VF<->PF MAC/VLAN requests

 drivers/net/ethernet/intel/fm10k/fm10k.h        |  53 +++-
 drivers/net/ethernet/intel/fm10k/fm10k_common.c |   6 +-
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c    | 160 ++++++++--
 drivers/net/ethernet/intel/fm10k/fm10k_main.c   |   1 +
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c    |   4 +-
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 207 ++++++++++---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c    | 395 ++++++++++++++++++------
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c     |  12 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pf.h     |   3 +-
 9 files changed, 662 insertions(+), 179 deletions(-)

-- 
2.13.0.598.gf927b9495246

