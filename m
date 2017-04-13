From: kbuild test robot <lkp@intel.com>
Date: Thu, 13 Apr 2017 14:39:29 +0800
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbevf: Check for RSS key before
 setting value
In-Reply-To: <20170412202107.55834-3-anthony.l.nguyen@intel.com>
Message-ID: <201704131424.ocJX3tao%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Tony,

[auto build test WARNING on jkirsher-next-queue/dev-queue]
[also build test WARNING on v4.11-rc6 next-20170412]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tony-Nguyen/ixgbe-Check-for-RSS-key-before-setting-value/20170413-101808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue


coccinelle warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:1683:8-9: WARNING: return of 0/1 in function 'ixgbevf_init_rss_key' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
