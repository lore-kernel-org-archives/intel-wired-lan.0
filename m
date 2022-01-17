From: Corinna Vinschen <vinschen@redhat.com>
Date: Mon, 17 Jan 2022 19:29:12 +0100
Subject: [Intel-wired-lan] [PATCH 0/3 net-next v5] igb/igc: fix XDP
 registration
Message-ID: <20220117182915.1283151-1-vinschen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the kernel warning "Missing unregister, handled but fix driver"
when running, e.g.,

  $ ethtool -G eth0 rx 1024

on igc.  Remove memset hack from igb and align igb code to igc. 

v3: use dev_err rather than netdev_err, just as in error case.
v4: fix a return copy/pasted from original igc code into the correct
    `goto err', improve commit message.
v5: add missing dma_free_coherent calls in error case.

Corinna Vinschen (2):
  igc: avoid kernel warning when changing RX ring parameters
  igb: refactor XDP registration
  igb/igc: RX queues: fix DMA leak in error case

 drivers/net/ethernet/intel/igb/igb_ethtool.c |  4 ----
 drivers/net/ethernet/intel/igb/igb_main.c    | 13 +++++++++---
 drivers/net/ethernet/intel/igc/igc_main.c    | 21 +++++++++++---------
 3 files changed, 22 insertions(+), 16 deletions(-)

-- 
2.27.0

