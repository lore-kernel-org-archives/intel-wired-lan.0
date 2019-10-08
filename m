From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 08 Oct 2019 14:16:32 -0700
Subject: [Intel-wired-lan] [next-queue PATCH 0/2] Address IRQ related crash
 seen due to io_perm_failure
Message-ID: <20191008210639.4575.44144.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

David Dai had submitted a patch[1] to address a reported issue with e1000e
calling pci_disable_msi without first freeing the interrupts. Looking over
the issue it seems the problem was the fact that e1000e_down was being
called in e1000_io_error_detected without calling e1000_free_irq, and this
was resulting in e1000e_close skipping over the call to e1000e_down and
e1000_free_irq.

The use of the __E1000_DOWN flag for the close test seems to have come from
the runtime power management changes that were made some time ago. From
what I can tell in the close path we should be disabling runtime power
management via a call to pm_runtime_get_sync. As such we can remove the
test for the __E1000_DOWN bit. However in comparing this with other drivers
we do need to avoid freeing the IRQs more than once. So in order to address
that I have copied the approach taken in igb and taken it a bit further so
that we will always detach the interface and if the interface is up we will
bring it down and free the IRQs. In addition we are able to reuse some of
the power management code so I have taken the opportunity to merge those
bits.

[1]: https://lore.kernel.org/lkml/1570121672-12172-1-git-send-email-zdai at linux.vnet.ibm.com/

---

Alexander Duyck (2):
      e1000e: Use rtnl_lock to prevent race conditions between net and pci/pm
      e1000e: Drop unnecessary __E1000_DOWN bit twiddling


 drivers/net/ethernet/intel/e1000e/netdev.c |   47 +++++++++++++---------------
 1 file changed, 22 insertions(+), 25 deletions(-)

--
