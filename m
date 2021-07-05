From: Taehee Yoo <ap420073@gmail.com>
Date: Mon,  5 Jul 2021 15:38:05 +0000
Subject: [Intel-wired-lan] [PATCH net v2 0/9] net: fix bonding ipsec offload
 problems
Message-ID: <20210705153814.11453-1-ap420073@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series fixes some problems related to bonding ipsec offload.

The 1, 5, and 8th patches are to add a missing rcu_read_lock().
The 2nd patch is to add null check code to bond_ipsec_add_sa.
When bonding interface doesn't have an active real interface, the
bond->curr_active_slave pointer is null.
But bond_ipsec_add_sa() uses that pointer without null check.
So that it results in null-ptr-deref.
The 3 and 4th patches are to replace xs->xso.dev with xs->xso.real_dev.
The 6th patch is to disallow to set ipsec offload if a real interface
type is bonding.
The 7th patch is to add struct bond_ipsec to manage SA.
If bond mode is changed, or active real interface is changed, SA should
be removed from old current active real interface then it should be added
to new active real interface.
But it can't, because it doesn't manage SA.
The 9th patch is to fix incorrect return value of bond_ipsec_offload_ok().

v1 -> v2:
 - Add 9th patch.
 - Do not print warning when there is no SA in bond_ipsec_add_sa_all().
 - Add comment for ipsec_lock.

Taehee Yoo (9):
  bonding: fix suspicious RCU usage in bond_ipsec_add_sa()
  bonding: fix null dereference in bond_ipsec_add_sa()
  net: netdevsim: use xso.real_dev instead of xso.dev in callback
    functions of struct xfrmdev_ops
  ixgbevf: use xso.real_dev instead of xso.dev in callback functions of
    struct xfrmdev_ops
  bonding: fix suspicious RCU usage in bond_ipsec_del_sa()
  bonding: disallow setting nested bonding + ipsec offload
  bonding: Add struct bond_ipesc to manage SA
  bonding: fix suspicious RCU usage in bond_ipsec_offload_ok()
  bonding: fix incorrect return value of bond_ipsec_offload_ok()

 drivers/net/bonding/bond_main.c            | 181 +++++++++++++++++----
 drivers/net/ethernet/intel/ixgbevf/ipsec.c |  20 ++-
 drivers/net/netdevsim/ipsec.c              |   8 +-
 include/net/bonding.h                      |   9 +-
 4 files changed, 178 insertions(+), 40 deletions(-)

-- 
2.17.1

