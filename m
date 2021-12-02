From: kernel test robot <lkp@intel.com>
Date: Thu, 2 Dec 2021 19:48:55 +0800
Subject: [Intel-wired-lan] [PATCH v4 net-next 2/4] ethtool: Add ability
 to configure recovered clock for SyncE feature
In-Reply-To: <20211201180208.640179-3-maciej.machnikowski@intel.com>
References: <20211201180208.640179-3-maciej.machnikowski@intel.com>
Message-ID: <202112021948.p1Sqfiw5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Maciej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Maciej-Machnikowski/Add-ethtool-interface-for-SyncE/20211202-021915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 23ea630f86c70cbe6691f9f839e7b6742f0e9ad3
reproduce: make htmldocs

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

include/uapi/linux/ethtool.h:1: warning: 'ethtool_rclk_pin_state' not found

vim +/ethtool_rclk_pin_state +1 include/uapi/linux/ethtool.h

6f52b16c5b29b8 Greg Kroah-Hartman 2017-11-01  @1  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
607ca46e97a1b6 David Howells      2012-10-13   2  /*
607ca46e97a1b6 David Howells      2012-10-13   3   * ethtool.h: Defines for Linux ethtool.
607ca46e97a1b6 David Howells      2012-10-13   4   *
607ca46e97a1b6 David Howells      2012-10-13   5   * Copyright (C) 1998 David S. Miller (davem at redhat.com)
607ca46e97a1b6 David Howells      2012-10-13   6   * Copyright 2001 Jeff Garzik <jgarzik@pobox.com>
607ca46e97a1b6 David Howells      2012-10-13   7   * Portions Copyright 2001 Sun Microsystems (thockin at sun.com)
607ca46e97a1b6 David Howells      2012-10-13   8   * Portions Copyright 2002 Intel (eli.kupermann at intel.com,
607ca46e97a1b6 David Howells      2012-10-13   9   *                                christopher.leech at intel.com,
607ca46e97a1b6 David Howells      2012-10-13  10   *                                scott.feldman at intel.com)
607ca46e97a1b6 David Howells      2012-10-13  11   * Portions Copyright (C) Sun Microsystems 2008
607ca46e97a1b6 David Howells      2012-10-13  12   */
607ca46e97a1b6 David Howells      2012-10-13  13  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
