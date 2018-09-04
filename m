From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue,  4 Sep 2018 20:11:01 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 0/4] i40e AF_XDP zero-copy buffer
 leak fixes
Message-ID: <20180904181105.10983-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

This series addresses an AF_XDP zero-copy issue that buffers passed
from userspace to the kernel was leaked when the hardware descriptor
ring was torn down.

The patches fixes the i40e AF_XDP zero-copy implementation.

Thanks to Jakub Kicinski for pointing this out!

Some background for folks that don't know the details: A zero-copy
capable driver picks buffers off the fill ring and places them on the
hardware Rx ring to be completed at a later point when DMA is
complete. Similar on the Tx side; The driver picks buffers off the Tx
ring and places them on the Tx hardware ring.

In the typical flow, the Rx buffer will be placed onto an Rx ring
(completed to the user), and the Tx buffer will be placed on the
completion ring to notify the user that the transfer is done.

However, if the driver needs to tear down the hardware rings for some
reason (interface goes down, reconfiguration and such), the userspace
buffers cannot be leaked. They have to be reused or completed back to
userspace.

The implementation does the following:

* Outstanding Tx descriptors will be passed to the completion
  ring. The Tx code has back-pressure mechanism in place, so that
  enough empty space in the completion ring is guaranteed.

* Outstanding Rx descriptors are temporarily stored on a stash/reuse
  queue. The reuse queue is based on Jakub's RFC. When/if the HW rings
  comes up again, entries from the stash are used to re-populate the
  ring.

* When AF_XDP ZC is enabled, disallow changing the number of hardware
  descriptors via ethtool. Otherwise, the size of the stash/reuse
  queue can grow unbounded.

Going forward, introducing a "zero-copy allocator" analogous to Jesper
Brouer's page pool would be a more robust and reuseable solution.

Jakub: I've made a minor checkpatch-fix to your RFC, prior adding it
into this series.


Thanks!
Bj?rn

Bj?rn T?pel (3):
  i40e: clean zero-copy XDP Tx ring on shutdown/reset
  i40e: clean zero-copy XDP Rx ring on shutdown/reset
  i40e: disallow changing the number of descriptors when AF_XDP is on

Jakub Kicinski (1):
  net: xsk: add a simple buffer reuse queue

 .../net/ethernet/intel/i40e/i40e_ethtool.c    |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  21 ++-
 .../ethernet/intel/i40e/i40e_txrx_common.h    |   4 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 152 +++++++++++++++++-
 include/net/xdp_sock.h                        |  43 +++++
 net/xdp/xdp_umem.c                            |   2 +
 net/xdp/xsk_queue.c                           |  55 +++++++
 net/xdp/xsk_queue.h                           |   3 +
 8 files changed, 273 insertions(+), 16 deletions(-)

-- 
2.17.1

