From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Fri, 01 May 2015 10:34:32 -0700
Subject: [Intel-wired-lan] [net PATCH 0/3] Clean-up some bits related to
	netpoll
Message-ID: <20150501173049.1029.54421.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set cleans up some minor items related to netpoll.  The first
patch addresses an Rx clean-up bug that is triggered due to an assumption
that napi->poll wouldn't be called with a budget of 0.  The other two
patches address dev_kfree_skb being called in the xmit path which isn't
valid since netpoll will call ndo_start_xmit with IRQs disabled.

---

Alexander Duyck (3):
      fm10k: Do not assume budget will never be 0 for NAPI
      r8169: Do not use dev_kfree_skb in xmit path
      ixgbevf: Use dev_kfree_skb_any in xmit path, not dev_kfree_skb


 drivers/net/ethernet/intel/fm10k/fm10k_main.c     |    4 ++--
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    2 +-
 drivers/net/ethernet/realtek/r8169.c              |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

--
