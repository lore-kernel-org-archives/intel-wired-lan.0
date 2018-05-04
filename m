From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 03 May 2018 17:39:10 -0700
Subject: [Intel-wired-lan] [RFC PATCH 0/2] ixgbe/ixgbevf: Add support for
 UDP segmentation offload
Message-ID: <20180504003556.4769.11407.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These patches are meant to be a follow-up to the following series:
https://patchwork.ozlabs.org/project/netdev/list/?series=42476&archive=both&state=*

These patches enable driver support for the new UDP segmentation offload
feature. For now I am pushing them as an RFC as they haven't been
officially productized or validated and I was using these mostly as a test
vehicle to verify the offload could be supported generically by drivers.

---

Alexander Duyck (2):
      ixgbe: Add support for UDP segmentation offload
      ixgbevf: Add support for UDP segmentation offload


 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   24 +++++++++++++++-----
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   25 ++++++++++++++++-----
 2 files changed, 37 insertions(+), 12 deletions(-)

--
