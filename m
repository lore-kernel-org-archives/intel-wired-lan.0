From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 07 Sep 2016 20:28:02 -0700
Subject: [Intel-wired-lan] [next PATCH 0/3] Add support for 4 queues VFs
 with 1 or 2 queue RSS on PF
Message-ID: <20160908032606.25312.86849.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set addresses a few minor issues and allows us to enable 4 queue
RSS on the VFs if the PF if configured for less than 4 queues.  I found and
fixed at least 2 buts with the first 2 patches in this set, and the third
patch enables us to have 4 queues with RSS assuming that we have not
exceeded 32 total VM pools and DCB is not enabled.

---

Alexander Duyck (3):
      ixgbe: Allow setting multiple queues when SR-IOV is enabled
      ixgbe: Limit reporting of redirection table if SR-IOV is enabled
      ixgbe: Support 4 queue RSS on VFs with 1 or 2 queue RSS on PF


 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   10 +++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |    7 ++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   12 +++++++-----
 3 files changed, 18 insertions(+), 11 deletions(-)

--
