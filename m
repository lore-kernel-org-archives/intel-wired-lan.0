From: Wang Hai <wanghai38@huawei.com>
Date: Thu, 10 Sep 2020 23:04:26 +0800
Subject: [Intel-wired-lan] [PATCH net-next 0/3] Fix some kernel-doc warnings
 for e1000/e1000e
Message-ID: <20200910150429.31912-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Wang Hai (3):
  e1000e: Fix some kernel-doc warnings in ich8lan.c
  e1000e: Fix some kernel-doc warnings in netdev.c
  e1000: Fix a bunch of kerneldoc parameter issues in e1000_hw.c

 drivers/net/ethernet/intel/e1000/e1000_hw.c | 7 +------
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
 drivers/net/ethernet/intel/e1000e/netdev.c  | 6 ++----
 3 files changed, 5 insertions(+), 12 deletions(-)

-- 
2.17.1

