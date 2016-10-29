From: Mao Wenan <maowenan@huawei.com>
Date: Sat, 29 Oct 2016 15:08:51 +0800
Subject: [Intel-wired-lan] [PATCH] add one parameter wro_enable to enable
	relaxed ordering for IXGBE
Message-ID: <1477724932-5440-1-git-send-email-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch provides a way to enable relaxed ordering, where it helps with performance in some architecture.
The default value of wro_enable is 0, if you want to enable relaxed ordering, please set wro_enable=1.

Mao Wenan (1):
  add one parameter wro_enable for IXGBE

 drivers/net/ethernet/intel/ixgbe/ixgbe.h        |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c  | 29 ++++++++++++++-----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 28 +++++++++++++-----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |  9 ++++++++
 4 files changed, 41 insertions(+), 26 deletions(-)

-- 
2.5.0


