From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Date: Fri, 7 Sep 2018 19:19:33 +0800
Subject: [Intel-wired-lan] [PATCH v3 0/2] net: ethernet: i40e/i40evf fix
 build error
Message-ID: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i40e: function __i40e_add_stat_strings can never be inlined because it uses
variable argument lists.

i40evf: A risk of "Multiple definition" from cross-including.

I am working on aarch64 platform and unfortunately the config file is MODULE.
So I missed the buildin test... Sorry for pushing this patch to v3 version...

Now I tested this patch with buildin and modules.

Tested on: x86_64, make ARCH=i386

Modules section .text:
i40e: 00019380 <__i40e_add_stat_strings>:
i40evf: 00006b00 <__i40e_add_stat_strings>:

Buildin:
i40e: c351ca60 <__i40e_add_stat_strings>:
i40evf: c354f2c0 <__i40e_add_stat_strings>:


Wang Dongsheng (2):
  net: ethernet: i40e: fix build error
  net: ethernet: i40evf: fix underlying build error

 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 24 ++++++++++++++++++
 .../ethernet/intel/i40e/i40e_ethtool_stats.h  | 25 ++-----------------
 .../intel/i40evf/i40e_ethtool_stats.h         | 23 +----------------
 .../ethernet/intel/i40evf/i40evf_ethtool.c    | 24 ++++++++++++++++++
 4 files changed, 51 insertions(+), 45 deletions(-)

-- 
2.18.0

