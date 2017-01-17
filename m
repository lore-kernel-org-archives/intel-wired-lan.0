From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Jan 2017 08:35:18 -0800
Subject: [Intel-wired-lan] [next PATCH v2 00/11] Add support for writable
	pages and build_skb
Message-ID: <20170117163401.5423.37993.stgit@localhost.localdomain>
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
possible including RSC, FCoE, SR-IOV, and Jumbo Frames all while receiving
traffic.

Within the patches there is also some intialization changes.  Specifically
I have updated the code paths to defer clearing the rings until we are
about to initialize them and give them to hardware.  By doing this we are
able to avoid having to dirty memory we don't need to which should help to
improve suspend/resume times for when we start looking at possibly using
the suspend/resume approach for migration of interface in VMs.

v2: Fixes for build issues on non-x86 architectures
    Fixes for issues ethtool issues found during testing

---

Alexander Duyck (11):
      ixgbe: Add function for checking to see if we can reuse page
      ixgbe: Only DMA sync frame length
      ixgbe: Update driver to make use of DMA attributes in Rx path
      ixgbe: Update code to better handle incrementing page count
      ixgbe: Make use of order 1 pages and 3K buffers independent of FCoE
      ixgbe: Use length to determine if descriptor is done
      ixgbe: Break out Rx buffer page management
      ixgbe: Add support for padding packet
      ixgbe: Add private flag to control buffer mode
      ixgbe: Add support for build_skb
      ixgbe: Don't bother clearing buffer memory for descriptor rings


 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   45 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   60 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  585 ++++++++++++++--------
 3 files changed, 467 insertions(+), 223 deletions(-)

--
