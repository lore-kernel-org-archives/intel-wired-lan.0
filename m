From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 27 Oct 2015 16:59:05 -0700
Subject: [Intel-wired-lan] [next PATCH 0/5] Misc Intel driver cleanups
Message-ID: <20151027235341.30048.46286.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These are some assorted cleanups that occurred to me over the last several
days.  They are compile tested only.

The first three are based on review of some patches I saw recently accepted
into fm10k.  We weren't doing consistent exception handling when we
probably should have been.  Also it looks like there are some exception
paths what would have likely resulted in a kernel panic so I decided to try
and address those.

The fourth is based on a suggestion I had given to Nick but he ignored.
Basically e1000e_up is always returning 0, there was code that was checking
for it returning non-zero so I make e1000e_up void and dropped all code
that was checking it for a non-zero return value.

The last patch is a minor tweak to an existing patch in the dev-queue.
Feel free to just fold it into the patch it fixes and add my signed-off-by
or carry it separately.  I am good either way.

---

Alexander Duyck (5):
      fm10k: Cleanup MSI-X interrupts in case of failure
      fm10k: Cleanup exception handling for mailbox interrupt
      fm10k: Cleanup exception handling for changing queues
      e1000e: Switch e1000e_up to void, drop code checking for error result
      igb: Fix unused variable warning


 drivers/net/ethernet/intel/e1000e/e1000.h       |    2 -
 drivers/net/ethernet/intel/e1000e/netdev.c      |   15 +----
 drivers/net/ethernet/intel/fm10k/fm10k_main.c   |    4 +
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |   17 ++++--
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |   68 ++++++++++++++++++-----
 drivers/net/ethernet/intel/igb/igb_main.c       |    1 
 6 files changed, 74 insertions(+), 33 deletions(-)

--
