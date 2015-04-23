From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Wed, 22 Apr 2015 21:49:10 -0700
Subject: [Intel-wired-lan] [PATCH 0/3] igb/fm10k/ixgbevf: Drop XXX_pull_tail
 and pull header in XXX_add_rx_frag
Message-ID: <20150423040941.18903.3545.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These three patches remove the _pull_tail functions for the drivers igb,
fm10k, and ixgbevf in favor of simply pulling the header in all cases at
the start of _add_rx_frag.

For igb this might be considered a driver fix, but the issue would be a
corner case in which timestamping is enabled, a packet is received that is 
between 241 and 255 bytes in size, and the header contains bad data which 
places its size something greater than the actual size.

The ixgbe driver is excluded from this set as it cannot support this due to
RSC overwriting the header data until the EOP and DD bit are written in the
last descriptor.

---

Alexander Duyck (3):
      igb: Pull timestamp from fragment before adding it to skb
      fm10k: fold fm10k_pull_tail into fm10k_add_rx_frag
      ixgbevf: fold ixgbevf_pull_tail into ixgbevf_add_rx_frag


 drivers/net/ethernet/intel/fm10k/fm10k_main.c     |   66 ++++-----------
 drivers/net/ethernet/intel/igb/igb_main.c         |   94 ++++++---------------
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   66 ++++-----------
 3 files changed, 64 insertions(+), 162 deletions(-)

--
