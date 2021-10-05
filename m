From: Switzer, David <david.switzer@intel.com>
Date: Tue, 5 Oct 2021 22:33:02 +0000
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix freeing of
 unitialized misc IRQ vector
In-Reply-To: <20210924094041.15448-1-mateusz.palczewski@intel.com>
References: <20210924094041.15448-1-mateusz.palczewski@intel.com>
Message-ID: <MW3PR11MB474846805BB49B48810BE689EBAF9@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Palczewski, Mateusz
>Sent: Friday, September 24, 2021 2:41 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Dziedziuch, SylwesterX <sylwesterx.dziedziuch@intel.com>; PJ
>Waskiewicz <pwaskiewicz@jumptrading.com>; Palczewski, Mateusz
><mateusz.palczewski@intel.com>
>Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix freeing of unitialized misc
>IRQ vector
>
>From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
>
>When VSI set up failed in i40e_probe() as part of PF switch set up driver was
>trying to free misc IRQ vectors in i40e_clear_interrupt_scheme and produced
>a kernel Oops:
>
>   Trying to free already-free IRQ 266
>   WARNING: CPU: 0 PID: 5 at kernel/irq/manage.c:1731
>__free_irq+0x9a/0x300
>   Workqueue: events work_for_cpu_fn
>   RIP: 0010:__free_irq+0x9a/0x300
>   Call Trace:
>   ? synchronize_irq+0x3a/0xa0
>   free_irq+0x2e/0x60
>   i40e_clear_interrupt_scheme+0x53/0x190 [i40e]
>   i40e_probe.part.108+0x134b/0x1a40 [i40e]
>   ? kmem_cache_alloc+0x158/0x1c0
>   ? acpi_ut_update_ref_count.part.1+0x8e/0x345
>   ? acpi_ut_update_object_reference+0x15e/0x1e2
>   ? strstr+0x21/0x70
>   ? irq_get_irq_data+0xa/0x20
>   ? mp_check_pin_attr+0x13/0xc0
>   ? irq_get_irq_data+0xa/0x20
>   ? mp_map_pin_to_irq+0xd3/0x2f0
>   ? acpi_register_gsi_ioapic+0x93/0x170
>   ? pci_conf1_read+0xa4/0x100
>   ? pci_bus_read_config_word+0x49/0x70
>   ? do_pci_enable_device+0xcc/0x100
>   local_pci_probe+0x41/0x90
>   work_for_cpu_fn+0x16/0x20
>   process_one_work+0x1a7/0x360
>   worker_thread+0x1cf/0x390
>   ? create_worker+0x1a0/0x1a0
>   kthread+0x112/0x130
>   ? kthread_flush_work_fn+0x10/0x10
>   ret_from_fork+0x1f/0x40
>
>The problem is that at that point misc IRQ vectors were not allocated yet and
>we get a call trace that driver is trying to free already free IRQ vectors.
>
>Add a check in i40e_clear_interrupt_scheme for
>__I40E_MISC_IRQ_REQUESTED PF state before calling i40e_free_misc_vector.
>This state is set only if misc IRQ vectors were properly initialized.
>
>Fixes: c17401a1dd21 ("i40e: use separate state bit for miscellaneous IRQ
>setup")
>Reported-by: PJ Waskiewicz <pwaskiewicz@jumptrading.com>
>Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
>Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Tested-by: Dave Switzer <david.switzer@intel.com>

 

