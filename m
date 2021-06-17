From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Thu, 17 Jun 2021 14:22:28 -0400
Subject: [Intel-wired-lan] [PATCH v1 00/14] genirq: Cleanup the usage of
 irq_set_affinity_hint
Message-ID: <20210617182242.8637-1-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The drivers currently rely on irq_set_affinity_hint() to either set the
affinity_hint that is consumed by the userspace and/or to enforce a custom
affinity.

irq_set_affinity_hint() as the name suggests is originally introduced to
only set the affinity_hint to help the userspace in guiding the interrupts
and not the affinity itself. However, since the commit

	e2e64a932556 "genirq: Set initial affinity in irq_set_affinity_hint()"

irq_set_affinity_hint() also started applying the provided cpumask (if not
NULL) as the affinity for the interrupts. The issue that this commit was
trying to solve is to allow the drivers to enforce their affinity mask to
distribute the interrupts across the CPUs such that they don't always end
up on CPU0. This issue has been resolved within the irq subsystem since the
commit

	a0c9259dc4e1 "irq/matrix: Spread interrupts on allocation"

Hence, there is no need for the drivers to overwrite the affinity to spread
as it is dynamically performed at the time of allocation.

Also, irq_set_affinity_hint() setting affinity unconditionally introduces
issues for the drivers that only want to set their affinity_hint and not the
affinity itself as for these driver interrupts the default_smp_affinity_mask
is completely ignored (for detailed investigation please refer to [1]).

Unfortunately reverting the commit e2e64a932556 is not an option at this
point for two reasons [2]:

- Several drivers for a valid reason (performance) rely on this API to
? enforce their own affinity mask

- Until very recently this was the only exported interface that was
? available

To clear this out Thomas has come up with the following interfaces:

- irq_set_affinity(): only sets affinity of an IRQ [3]
- irq_update_affinity_hint(): Only sets the hint [4]
- irq_set_affinity_and_hint(): Sets both affinity and the hint mask [4]

The first API is already merged in the linux-next tree and a v2 for the
remaining two is included with this patch-set.

To move to the stage where we can safely get rid of the
irq_set_affinity_hint(), which has been marked deprecated, we have to
move all its consumers to these new interfaces. In this patch-set, I have
done that for a few drivers and will hopefully try to move the remaining of
them in the coming days.

Testing
-------
In terms of testing, I have performed some basic testing on x86 to verify
things such as the interrupts are evenly spread on all CPUs, hint mask is
correctly set etc. for the drivers - i40e, iavf, mlx5, mlx4, ixgbe, i40iw
and enic on top of:
	git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 
	master - 5.13.0-rc6
So more testing is probably required for these and the drivers that I didn't
test and any help will be much appreciated.

[1] https://lore.kernel.org/lkml/1a044a14-0884-eedb-5d30-28b4bec24b23 at redhat.com/
[2] https://lore.kernel.org/linux-pci/d1d5e797-49ee-4968-88c6-c07119343492 at arm.com/
[3] https://lore.kernel.org/linux-arm-kernel/20210518091725.046774792 at linutronix.de/
[4] https://lore.kernel.org/patchwork/patch/1434326/


Nitesh Narayan Lal (13):
  iavf: Use irq_update_affinity_hint
  i40e: Use irq_update_affinity_hint
  scsi: megaraid_sas: Use irq_set_affinity_and_hint
  scsi: mpt3sas: Use irq_set_affinity_and_hint
  RDMA/i40iw: Use irq_update_affinity_hint
  enic: Use irq_update_affinity_hint
  be2net: Use irq_update_affinity_hint
  ixgbe: Use irq_update_affinity_hint
  mailbox: Use irq_update_affinity_hint
  scsi: lpfc: Use irq_set_affinity
  hinic: Use irq_set_affinity_and_hint
  net/mlx5: Use irq_update_affinity_hint
  net/mlx4: Use irq_update_affinity_hint

Thomas Gleixner (1):
  genirq: Provide new interfaces for affinity hints

 drivers/infiniband/hw/i40iw/i40iw_main.c      |  4 +-
 drivers/mailbox/bcm-flexrm-mailbox.c          |  4 +-
 drivers/net/ethernet/cisco/enic/enic_main.c   |  6 +--
 drivers/net/ethernet/emulex/benet/be_main.c   |  4 +-
 drivers/net/ethernet/huawei/hinic/hinic_rx.c  |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  6 +--
 drivers/net/ethernet/mellanox/mlx4/eq.c       |  6 +--
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  6 +--
 drivers/scsi/lpfc/lpfc_init.c                 |  4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c     | 25 ++++++-----
 drivers/scsi/mpt3sas/mpt3sas_base.c           | 15 ++++---
 include/linux/interrupt.h                     | 41 ++++++++++++++++++-
 kernel/irq/manage.c                           |  8 ++--
 15 files changed, 95 insertions(+), 54 deletions(-)

--  

