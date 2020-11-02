From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue,  3 Nov 2020 00:13:05 +0100
Subject: [Intel-wired-lan] [PATCH 0/2] Upstream ONL patch for PHY BCM5461S
Message-ID: <20201102231307.13021-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux folks,


Looking a little bit at Open Network Linux, they carry some Linux
patches, but have not upstreamed them yet. This upstreams support for
the PHY BCM5461S. It?d be great, if you could help review it.


Kind regards,

Paul


Jeffrey Townsend (2):
  ethernet: igb: Support PHY BCM5461S
  ethernet: igb: e1000_phy: Check for ops.force_speed_duplex existence

 drivers/net/ethernet/intel/igb/e1000_82575.c  | 23 ++++-
 .../net/ethernet/intel/igb/e1000_defines.h    |  1 +
 drivers/net/ethernet/intel/igb/e1000_hw.h     |  1 +
 drivers/net/ethernet/intel/igb/e1000_phy.c    | 89 +++++++++++++++++--
 drivers/net/ethernet/intel/igb/e1000_phy.h    |  2 +
 drivers/net/ethernet/intel/igb/igb_main.c     |  8 ++
 6 files changed, 118 insertions(+), 6 deletions(-)

-- 
2.29.1

