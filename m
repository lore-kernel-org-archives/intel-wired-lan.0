From: Julia Lawall <julia.lawall@inria.fr>
Date: Wed, 15 Apr 2020 16:18:57 +0200 (CEST)
Subject: [Intel-wired-lan] [jkirsher-next-queue:rdma 24/25]
 drivers/infiniband/hw/irdma/irdma_if.c:138:56-61: WARNING: conversion to
 bool not needed here (fwd)
Message-ID: <alpine.DEB.2.21.2004151617570.2381@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

I have forwarded patches about the first and third issues below, but there
is another issue about a duplicated argument to & or | that could be
looked into.

julia

---------- Forwarded message ----------
Date: Wed, 15 Apr 2020 22:04:23 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp at intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: [jkirsher-next-queue:rdma 24/25]
    drivers/infiniband/hw/irdma/irdma_if.c:138:56-61: WARNING: conversion to
    bool not needed here

CC: kbuild-all at lists.01.org
CC: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
TO: Shiraz Saleem <shiraz.saleem@intel.com>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git rdma
head:   4d75d9adac8df983bc733b92711683a7cd7ddd40
commit: f473122f41f69394e29a834fbfcd569dcdd1d879 [24/25] RDMA/irdma: Add irdma Kconfig/Makefile and remove i40iw
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/infiniband/hw/irdma/irdma_if.c:138:56-61: WARNING: conversion to bool not needed here
--
>> drivers/infiniband/hw/irdma/ctrl.c:581:7-59: duplicated argument to & or |
--
>> drivers/infiniband/hw/irdma/verbs.c:2387:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
