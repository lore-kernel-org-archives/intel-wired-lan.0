From: Corinna Vinschen <vinschen@redhat.com>
Date: Fri, 14 Jan 2022 20:45:18 +0100
Subject: [Intel-wired-lan] [PATCH 0/2 net-next v4] igb/igc: fix XDP
 registration
Message-ID: <20220114194520.1092894-1-vinschen@redhat.com>
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

Corinna Vinschen (2):
  igc: avoid kernel warning when changing RX ring parameters
  igb: refactor XDP registration

 drivers/net/ethernet/intel/igb/igb_ethtool.c |  4 ----
 drivers/net/ethernet/intel/igb/igb_main.c    | 12 +++++++++---
 drivers/net/ethernet/intel/igc/igc_main.c    | 20 +++++++++++---------
 3 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.27.0

