From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 22 Sep 2015 14:35:22 -0700
Subject: [Intel-wired-lan] [net PATCH 0/3] netpoll fixes for Intel drivers
Message-ID: <20150922213002.2774.37924.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

While reviewing some other patches related to netpoll I started looking at
how the drivers were handling their budgets.  It turns out that the ixgbe,
fm10k, and i40e drivers contained cases where they would increase the
budget from 0 and as a result it was possible for them to clean Rx frames
inside of netpoll context.

This patch set corrects that by adding a check before the Rx portion of the
polling routines for a budget less than or equal to 0.  If the value is in
that range we simply exit and leave ourselves on the polling list rather
than attempt to clean any Rx frames.

---

Alexander Duyck (3):
      i40e: Fix handling of napi budget
      fm10k: Fix handling of napi budget when multiple queues are enabled per vector
      ixgbe: Fix handling of napi budget when multiple queues are enabled per vector


 drivers/net/ethernet/intel/fm10k/fm10k_main.c |    4 ++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |    5 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

--
