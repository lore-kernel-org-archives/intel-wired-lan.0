From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Mon, 19 Jul 2021 14:07:32 -0400
Subject: [Intel-wired-lan] [PATCH v4 00/14] genirq: Cleanup the usage of
 irq_set_affinity_hint
Message-ID: <20210719180746.1008665-1-nitesh@redhat.com>
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
  enforce their affinity mask

- Until very recently this was the only exported interface that was
  available

To clear this out Thomas has come up with the following interfaces:

- irq_set_affinity(): only sets affinity of an IRQ [3]
- irq_update_affinity_hint(): Only sets the hint [4]
- irq_set_affinity_and_hint(): Sets both affinity and the hint mask [4]

The first API is already merged in the linus's tree and the patch
that introduces the other two interfaces is included with this patch-set.

To move to the stage where we can safely get rid of the
irq_set_affinity_hint(), which has been marked deprecated, we have to
move all its consumers to these new interfaces. In this patch-set, I have
done that for a few drivers and will hopefully try to move the remaining of
them in the coming days.

Testing
-------
In terms of testing, I have performed some basic testing on x86 to verify
things such as the interrupts are evenly spread on all CPUs, hint mask is
correctly set etc. for the drivers - i40e, iavf, mlx5, mlx4, ixgbe, and
enic on top of:

        git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

So more testing is probably required for these and the drivers that I didn't
test and any help will be much appreciated.


Notes
-----
- For the mpt3sas driver I decided to go with the usage of
  irq_set_affinity_and_hint over irq_set_affinity based on my analysis of
  it and the megaraid driver. However, if we are sure that it is not
  required then I can replace it with just irq_set_affinity as one of its
  comment suggests.

Change from v3 [5]
------------------
- Replaced irq_set_affinity_and_hint with irq_update_affinity_hint in
  irdma (Leon Romanovsky)
- rebased the patches on top of 5.14-rc2


Change from v2 [6]
------------------

- Rebased on top of 5.14-rc1 (Leon Romanovsky)
  + After discussion with Leon [7], made changes in the mlx5 patch to use
    irq_set_affinity_and_hint over irq_update_affinity_hint
  + i40iw is replaced with irdma driver, hence made the respective changes
    in irdma (also replcaed irq_update_affinity_hint with
    irq_set_affinity_and_hint).

Change from v1 [8]
------------------
- Fixed compilation error by adding the new interface definitions for cases
  where CONFIG_SMP is not defined

- Fixed function usage in megaraid_sas and removed unnecessary variable
  (Robin Murphy)

- Removed unwanted #if/endif from mlx4 (Leon Romanovsky)

- Other indentation related fixes

 
[1] https://lore.kernel.org/lkml/1a044a14-0884-eedb-5d30-28b4bec24b23 at redhat.com/
[2] https://lore.kernel.org/linux-pci/d1d5e797-49ee-4968-88c6-c07119343492 at arm.com/
[3] https://lore.kernel.org/linux-arm-kernel/20210518091725.046774792 at linutronix.de/
[4] https://lore.kernel.org/patchwork/patch/1434326/
[5] https://lore.kernel.org/linux-scsi/20210713211502.464259-1-nitesh at redhat.com/
[6] https://lore.kernel.org/lkml/20210629152746.2953364-1-nitesh at redhat.com/
[7] https://lore.kernel.org/lkml/YO0eKv2GJcADQTHH at unreal/
[8] https://lore.kernel.org/linux-scsi/20210617182242.8637-1-nitesh at redhat.com/

Nitesh Narayan Lal (13):
  iavf: Use irq_update_affinity_hint
  i40e: Use irq_update_affinity_hint
  scsi: megaraid_sas: Use irq_set_affinity_and_hint
  scsi: mpt3sas: Use irq_set_affinity_and_hint
  RDMA/irdma: Use irq_update_affinity_hint
  enic: Use irq_update_affinity_hint
  be2net: Use irq_update_affinity_hint
  ixgbe: Use irq_update_affinity_hint
  mailbox: Use irq_update_affinity_hint
  scsi: lpfc: Use irq_set_affinity
  hinic: Use irq_set_affinity_and_hint
  net/mlx5: Use irq_set_affinity_and_hint
  net/mlx4: Use irq_update_affinity_hint

Thomas Gleixner (1):
  genirq: Provide new interfaces for affinity hints

 drivers/infiniband/hw/irdma/hw.c              |  4 +-
 drivers/mailbox/bcm-flexrm-mailbox.c          |  4 +-
 drivers/net/ethernet/cisco/enic/enic_main.c   |  8 +--
 drivers/net/ethernet/emulex/benet/be_main.c   |  4 +-
 drivers/net/ethernet/huawei/hinic/hinic_rx.c  |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++--
 drivers/net/ethernet/mellanox/mlx4/eq.c       |  8 ++-
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  8 +--
 drivers/scsi/lpfc/lpfc_init.c                 |  4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c     | 27 +++++-----
 drivers/scsi/mpt3sas/mpt3sas_base.c           | 21 ++++----
 include/linux/interrupt.h                     | 53 ++++++++++++++++++-
 kernel/irq/manage.c                           |  8 +--
 15 files changed, 114 insertions(+), 65 deletions(-)

--  


