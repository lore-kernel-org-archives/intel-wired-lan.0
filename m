From: kbuild test robot <lkp@intel.com>
Date: Tue, 13 Oct 2015 10:10:42 +0800
Subject: [Intel-wired-lan] [PATCH v4 4/4] Adds hardware supported cross
	timestamp
In-Reply-To: <1444675522-4198-5-git-send-email-christopher.s.hall@intel.com>
Message-ID: <201510131014.80dMb5xV%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Christopher,

[auto build test ERROR on net/master -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Christopher-S-Hall/Patchset-enabling-hardware-based-cross-timestamps-for-next-gen-Intel-platforms/20151013-095135
config: sparc64-defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/e1000e/ptp.c:28:21: fatal error: asm/tsc.h: No such file or directory
    #include <asm/tsc.h>
                        ^
   compilation terminated.

vim +28 drivers/net/ethernet/intel/e1000e/ptp.c

    22	/* PTP 1588 Hardware Clock (PHC)
    23	 * Derived from PTP Hardware Clock driver for Intel 82576 and 82580 (igb)
    24	 * Copyright (C) 2011 Richard Cochran <richardcochran@gmail.com>
    25	 */
    26	
    27	#include "e1000.h"
  > 28	#include <asm/tsc.h>
    29	#include <linux/timekeeping.h>
    30	
    31	/**

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 16548 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151013/2b9e56f8/attachment.obj>
