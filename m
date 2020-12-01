From: Chen Yu <yu.c.chen@intel.com>
Date: Tue,  1 Dec 2020 09:21:14 +0800
Subject: [Intel-wired-lan] [PATCH 0/2][v3] Put the NIC in runtime suspended
 during s2ram
Message-ID: <cover.1606757180.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The NIC is put in runtime suspend status when there is no cable connected.
As a result, it is safe to keep non-wakeup NIC in runtime suspended during
s2ram because the system does not rely on the NIC plug event nor WoL to wake
up the system. Besides that, unlike the s2idle, s2ram does not need to
manipulate S0ix settings during suspend.

Chen Yu (2):
  e1000e: Leverage direct_complete to speed up s2ram
  e1000e: Remove the runtime suspend restriction on CNP+

 drivers/net/ethernet/intel/e1000e/netdev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.17.1

