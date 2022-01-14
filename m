From: Corinna Vinschen <vinschen@redhat.com>
Date: Fri, 14 Jan 2022 12:43:52 +0100
Subject: [Intel-wired-lan] [PATCH 0/2 net-next v2] igb/igc: fix XDP
 registration
Message-ID: <20220114114354.1071776-1-vinschen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the kernel warning "Missing unregister, handled but fix driver"
when running, e.g.,

  $ ethtool -G eth0 rx 1024

on igc.  Remove memset hack from igb and align igb code to igc. 

Corinna Vinschen (2):
  igc: avoid kernel warning when changing RX ring parameters
  igb: refactor XDP registration

 drivers/net/ethernet/intel/igb/igb_ethtool.c |  4 ----
 drivers/net/ethernet/intel/igb/igb_main.c    | 15 +++++++++++----
 drivers/net/ethernet/intel/igc/igc_main.c    | 20 +++++++++++---------
 3 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.27.0

