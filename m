From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 3 Oct 2019 10:39:49 -0700
Subject: [Intel-wired-lan] [v1] e1000e: EEH on e1000e adapter detects io
 perm failure can trigger crash
In-Reply-To: <1570121672-12172-1-git-send-email-zdai@linux.vnet.ibm.com>
References: <1570121672-12172-1-git-send-email-zdai@linux.vnet.ibm.com>
Message-ID: <CAKgT0Udz7vt5C=+6vpFPbys4sODAZtCjrkSvOdgP80rX7Ww+Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Oct 3, 2019 at 9:59 AM David Dai <zdai@linux.vnet.ibm.com> wrote:
>
> We see the behavior when EEH e1000e adapter detects io permanent failure,
> it will crash kernel with this stack:
> EEH: Beginning: 'error_detected(permanent failure)'
> EEH: PE#900000 (PCI 0115:90:00.1): Invoking e1000e->error_detected(permanent failure)
> EEH: PE#900000 (PCI 0115:90:00.1): e1000e driver reports: 'disconnect'
> EEH: PE#900000 (PCI 0115:90:00.0): Invoking e1000e->error_detected(permanent failure)
> EEH: PE#900000 (PCI 0115:90:00.0): e1000e driver reports: 'disconnect'
> EEH: Finished:'error_detected(permanent failure)'
> Oops: Exception in kernel mode, sig: 5 [#1]
> NIP [c0000000007b1be0] free_msi_irqs+0xa0/0x280
>  LR [c0000000007b1bd0] free_msi_irqs+0x90/0x280
> Call Trace:
> [c0000004f491ba10] [c0000000007b1bd0] free_msi_irqs+0x90/0x280 (unreliable)
> [c0000004f491ba70] [c0000000007b260c] pci_disable_msi+0x13c/0x180
> [c0000004f491bab0] [d0000000046381ac] e1000_remove+0x234/0x2a0 [e1000e]
> [c0000004f491baf0] [c000000000783cec] pci_device_remove+0x6c/0x120
> [c0000004f491bb30] [c00000000088da6c] device_release_driver_internal+0x2bc/0x3f0
> [c0000004f491bb80] [c00000000076f5a8] pci_stop_and_remove_bus_device+0xb8/0x110
> [c0000004f491bbc0] [c00000000006e890] pci_hp_remove_devices+0x90/0x130
> [c0000004f491bc50] [c00000000004ad34] eeh_handle_normal_event+0x1d4/0x660
> [c0000004f491bd10] [c00000000004bf10] eeh_event_handler+0x1c0/0x1e0
> [c0000004f491bdc0] [c00000000017c4ac] kthread+0x1ac/0x1c0
> [c0000004f491be30] [c00000000000b75c] ret_from_kernel_thread+0x5c/0x80
>
> Basically the e1000e irqs haven't been freed at the time eeh is trying to
> remove the the e1000e device.
> Need to make sure when e1000e_close is called to bring down the NIC,
> if adapter error_state is pci_channel_io_perm_failure, it should also
> bring down the link and free irqs.
>
> Reported-by: Morumuri Srivalli  <smorumu1@in.ibm.com>
> Signed-off-by: David Dai <zdai@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index d7d56e4..cf618e1 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -4715,7 +4715,8 @@ int e1000e_close(struct net_device *netdev)
>
>         pm_runtime_get_sync(&pdev->dev);
>
> -       if (!test_bit(__E1000_DOWN, &adapter->state)) {
> +       if (!test_bit(__E1000_DOWN, &adapter->state) ||
> +           (adapter->pdev->error_state == pci_channel_io_perm_failure)) {
>                 e1000e_down(adapter, true);
>                 e1000_free_irq(adapter);

It seems like the issue is the fact that e1000_io_error_detected is
calling e1000e_down without the e1000_free_irq() bit. Instead of doing
this couldn't you simply add the following to e1000_is_slot_reset in
the "result = PCI_ERS_RESULT_DISCONNECT" case:
    if (netif_running(netdev)
        e1000_free_irq(adapter);

Alternatively we could look at freeing and reallocating the IRQs in
the event of an error like we do for the e1000e_pm_freeze and
e1000e_pm_thaw cases. That might make more sense since we are dealing
with an error we might want to free and reallocate the IRQ resources
assigned to the device.

Thanks.

- Alex
