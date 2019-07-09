From: kbuild test robot <lkp@intel.com>
Date: Tue, 09 Jul 2019 11:26:50 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 46065ef1595f1bba9b1c9ed45cb501b95ea23259
Message-ID: <5d24097a.w8iRnsbNNTW8ZbmY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 46065ef1595f1bba9b1c9ed45cb501b95ea23259  i40e: Remove unicast log when VF is leaving multicast mode

Regressions in current branch:

drivers/net//ethernet/intel/ice/ice_lib.c:3165:11: error: implicit declaration of function 'ice_schedule_reset'; did you mean 'ice_check_reset'? [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

TIMEOUT after 720m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 1

                                             

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
