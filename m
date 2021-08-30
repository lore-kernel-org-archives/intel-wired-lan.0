From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 30 Aug 2021 20:52:41 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] i40e: Avoid double IRQ free on
 error path in probe()
In-Reply-To: <20210826221916.127243-1-pwaskiewicz@jumptrading.com>
References: <20210826221916.127243-1-pwaskiewicz@jumptrading.com>
Message-ID: <50c21a769633c8efa07f49fc8b20fdfb544cf3c5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-08-26 at 17:19 -0500, PJ Waskiewicz wrote:
> This fixes an error path condition when probe() fails due to the
> default VSI not being available or online yet in the firmware. If
> that happens, the previous teardown path would clear the interrupt
> scheme, which also freed the IRQs with the OS. Then the error path
> for the switch setup (pre-VSI) would attempt to free the OS IRQs
> as well.

Hi PJ,

These comments are from the i40e team.

Yes in case we fail and go to err_vsis label in i40e_probe() we will
call i40e_reset_interrupt_capability twice but this is not a problem.
This is because pci_disable_msi/pci_disable_msix will be called only if
appropriate flags are set on PF and if this function is called ones it
will clear those flags. So even if we call
i40e_reset_interrupt_capability twice we will not disable msi vectors
twice.

The issue here is different however. It is failing in free_irq because
we are trying to free already free vector. This is because setup of
misc irq vectors in i40e_probe is done after i40e_setup_pf_switch. If
i40e_setup_pf_switch fails then we will jump to err_vsis and call
i40e_clear_interrupt_scheme which will try to free those misc irq
vectors which were not yet allocated. We should have the proper fix for
this ready soon.

