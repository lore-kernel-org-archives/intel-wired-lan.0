From: kbuild test robot <lkp@intel.com>
Date: Sun, 6 May 2018 09:56:33 +0800
Subject: [Intel-wired-lan] [PATCH v2 1/1] drivers core: multi-threading
 device shutdown
In-Reply-To: <20180505154040.28614-2-pasha.tatashin@oracle.com>
References: <20180505154040.28614-2-pasha.tatashin@oracle.com>
Message-ID: <201805060956.WLlHt6Gx%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Pavel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on v4.17-rc3 next-20180504]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pavel-Tatashin/multi-threading-device-shutdown/20180506-035150
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/base/core.c:2877:25: sparse: symbol 'device_root_tasks_done' was not declared. Should it be static?
   drivers/base/core.c:62:5: sparse: context imbalance in 'device_links_read_lock' - wrong count at exit
   drivers/base/core.c:67:6: sparse: context imbalance in 'device_links_read_unlock' - unexpected unlock

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
