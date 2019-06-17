From: kbuild test robot <lkp@intel.com>
Date: Mon, 17 Jun 2019 23:25:23 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Make watchdog use delayed work
In-Reply-To: <20190616145445.9637-1-detlev.casanova@gmail.com>
References: <20190616145445.9637-1-detlev.casanova@gmail.com>
Message-ID: <201906172310.xCz4u1rq%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Detlev,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jkirsher-next-queue/dev-queue]
[also build test WARNING on v5.2-rc5 next-20190617]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Detlev-Casanova/e1000e-Make-watchdog-use-delayed-work/20190617-154840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)


Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
