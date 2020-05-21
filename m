From: Chen Yu <yu.c.chen@intel.com>
Date: Fri, 22 May 2020 01:58:02 +0800
Subject: [Intel-wired-lan] [PATCH 0/2] Make WOL of e1000e consistent with
 sysfs device wakeup
Message-ID: <cover.1590081982.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently the WOL(Wake On Lan) bahavior of e1000e is not consistent with its corresponding
device wake up ability.
Fix this by:
1. Do not wake up the system via WOL if device wakeup is disabled
2. Make WOL display info from ethtool consistent with device wake up
   settings in sysfs

Chen Yu (2):
  e1000e: Do not wake up the system via WOL if device wakeup is disabled
  e1000e: Make WOL info in ethtool consistent with device wake up
    ability

 drivers/net/ethernet/intel/e1000e/ethtool.c |  2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c  | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.17.1

