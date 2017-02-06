From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 05 Feb 2017 20:26:51 -0800
Subject: [Intel-wired-lan] [next PATCH v4 00/12] igb: Add support for
 writable pages and build_skb
Message-ID: <20170206042508.14635.44702.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set enables support for using the recent changes that allow for
unmapping pages without invalidating their contents via
DMA_ATTR_SKIP_CPU_SYNC.  With this change DMA pages should be writable and
as a result we should be able to make use of build_skb which can be used to
drop the skb->head memory allocation, header parsing, and memcpy from the
receive path which can greatly help to improve performance.

My main concern at this point is that there might be an architecture where
I didn't get DMA_ATTR_SKIP_CPU_SYNC implemented that might still need it.
For that reason I have also added a ethtool private flag called out as
"legacy-rx".  If a platform encounters an issue where the Rx can possibly
corrupt data it can be enbled by running:
        ethtool --set-priv-flags DEVNAME legacy-rx on

The testing matrix for all of these patches is going to be pretty
extensive.  Basically we want to test these patches on as many platforms
and architectures as possible with as many features being toggled as
possible including SR-IOV and Jumbo Frames all while receiving traffic.

Within the patches there is also some intialization changes.  Specifically
I have updated the code paths to defer clearing the rings until we are
about to initialize them and give them to hardware.  By doing this we are
able to avoid having to dirty memory we don't need to which should help to
improve suspend/resume times for when we start looking at possibly using
the suspend/resume approach for migration of interface in VMs.

v2: Minor fixes to address a few issues found in testing
v3: Fix minor build issues reported by kbuild test robot
v4: Split patch 6 up into 4 separate patches to allow for better bisection

---

Alexander Duyck (12):
      igb: Add support for DMA_ATTR_WEAK_ORDERING
      igb: Use length to determine if descriptor is done
      igb: Clear Rx buffer_info in configure instead of clean
      igb: Don't bother clearing Tx buffer_info in igb_clean_tx_ring
      igb: Limit maximum frame Rx based on MTU
      igb: Only sync size of expected frame in ethtool testing
      igb: Use page_address offset from page instead of masking virtual address
      igb: Add support for ethtool private flag to allow use of legacy Rx
      igb: Add support for using order 1 pages to receive large frames
      igb: Add support for padding packet
      igb: Break out Rx buffer page management
      igb: Re-add support for build_skb in igb


 drivers/net/ethernet/intel/igb/igb.h         |   58 +++
 drivers/net/ethernet/intel/igb/igb_ethtool.c |   65 +++
 drivers/net/ethernet/intel/igb/igb_main.c    |  509 ++++++++++++++++----------
 drivers/net/ethernet/intel/igb/igb_ptp.c     |    3 
 4 files changed, 434 insertions(+), 201 deletions(-)

--
