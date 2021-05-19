From: Guangbin Huang <huangguangbin2@huawei.com>
Date: Wed, 19 May 2021 14:14:40 +0800
Subject: [Intel-wired-lan] [PATCH net-next 0/5] net: intel: some cleanups
Message-ID: <1621404885-20075-1-git-send-email-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patchset adds some cleanups for intel e1000/e1000e ethernet driver.

Hao Chen (5):
  net: e1000: remove repeated word "slot" for e1000_main.c
  net: e1000: remove repeated words for e1000_hw.c
  net: e1000e: remove repeated word "the" for ich8lan.c
  net: e1000e: remove repeated word "slot" for netdev.c
  net: e1000e: fix misspell word "retreived"

 drivers/net/ethernet/intel/e1000/e1000_hw.c   | 4 ++--
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c   | 2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    | 2 +-
 drivers/net/ethernet/intel/e1000e/phy.c       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.8.1

