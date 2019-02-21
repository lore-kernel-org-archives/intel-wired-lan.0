From: Joel Fernandes (Google) <joel@joelfernandes.org>
Date: Thu, 21 Feb 2019 00:49:37 -0500
Subject: [Intel-wired-lan] [PATCH RFC 0/5] RCU fixes for
 rcu_assign_pointer() usage
Message-ID: <20190221054942.132388-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These patches fix various RCU API usage issues found due to sparse errors as a
result of the recent check to add rcu_check_sparse() to rcu_assign_pointer().
The errors in many cases seem to indicate either an incorrect API usage, or
missing annotations. The annotations added can also help avoid future incorrect
usages and bugs so it is a good idea to do in any case.

These are only build/boot tested and I request for feedback from maintainers
and developers in the various areas the patches touch. Thanks for any feedback!

(There are still errors in rbtree.h but I have kept those for a later time
since fixing them is a bit more involved).

Joel Fernandes (Google) (5):
net: rtnetlink: Fix incorrect RCU API usage
ixgbe: Fix incorrect RCU API usage
sched/cpufreq: Fix incorrect RCU API usage
sched/topology: Annonate RCU pointers properly
rcuwait: Replace rcu_assign_pointer() with WRITE_ONCE

drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 ++--
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 17 ++++++++++++-----
include/linux/rcuwait.h                       |  2 +-
kernel/sched/cpufreq.c                        |  8 ++++++--
kernel/sched/sched.h                          | 14 +++++++-------
kernel/sched/topology.c                       | 12 ++++++------
net/core/rtnetlink.c                          |  4 ++--
7 files changed, 36 insertions(+), 25 deletions(-)

--
2.21.0.rc0.258.g878e2cd30e-goog

