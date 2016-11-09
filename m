From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 8 Nov 2016 19:23:51 -0800
Subject: [Intel-wired-lan] [PATCH v3] ixgbevf: handle race between close
 and suspend on shutdown
In-Reply-To: <20161108201800.10886.90964.stgit@localhost6.localdomain6>
References: <20161108201800.10886.90964.stgit@localhost6.localdomain6>
Message-ID: <CAKgT0Uc7i=YnVYhzGCwfiwrNzsBvkpVjS7r3Yn_myBtBe08DOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 8, 2016 at 12:18 PM, Emil Tantilov
<emil.s.tantilov@intel.com> wrote:
> When an interface is part of a namespace it is possible that
> ixgbevf_close() may be called while ixgbevf_suspend() is running
> which ends up in a double free WARN and/or a BUG in free_msi_irqs()
>
> To handle this situation we extend the rtnl_lock() to protect the
> call to netif_device_detach() and check for !netif_device_present()
> to avoid entering close while in suspend.
>
> Also added rtnl locks to ixgbevf_queue_reset_subtask().
>
> -v2 handle the race with netif_device_detach/present() and rtnl
> locks as suggested by Alex Duyck
>
> -v3 add rtnl locks and check in ixgbevf_remove()

I'm not sure where you got the idea that you needed to add the checks
to ixgbevf_remove, but I'm pretty sure you don't need to.

The call to unregister_netdev takes the rtnl_lock and will then call
close on the interface.  So you don't have to worry about racing
against anything that might take the rtnl.  As far as remove versus
suspend the two are protected by a PCI lock if I remember correctly so
you shouldn't be able to call both at the same time.

> CC: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index d316f50..eac594c 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -3242,6 +3242,9 @@ int ixgbevf_close(struct net_device *netdev)
>  {
>         struct ixgbevf_adapter *adapter = netdev_priv(netdev);
>
> +       if (!netif_device_present(netdev))
> +               return 0;
> +
>         ixgbevf_down(adapter);
>         ixgbevf_free_irq(adapter);
>
> @@ -3268,6 +3271,8 @@ static void ixgbevf_queue_reset_subtask(struct ixgbevf_adapter *adapter)
>          * match packet buffer alignment. Unfortunately, the
>          * hardware is not flexible enough to do this dynamically.
>          */
> +       rtnl_lock();
> +
>         if (netif_running(dev))
>                 ixgbevf_close(dev);
>
> @@ -3276,6 +3281,8 @@ static void ixgbevf_queue_reset_subtask(struct ixgbevf_adapter *adapter)
>
>         if (netif_running(dev))
>                 ixgbevf_open(dev);
> +
> +       rtnl_unlock();
>  }
>
>  static void ixgbevf_tx_ctxtdesc(struct ixgbevf_ring *tx_ring,
> @@ -3792,17 +3799,17 @@ static int ixgbevf_suspend(struct pci_dev *pdev, pm_message_t state)
>         int retval = 0;
>  #endif
>
> +       rtnl_lock();
>         netif_device_detach(netdev);
>
>         if (netif_running(netdev)) {
> -               rtnl_lock();
>                 ixgbevf_down(adapter);
>                 ixgbevf_free_irq(adapter);
>                 ixgbevf_free_all_tx_resources(adapter);
>                 ixgbevf_free_all_rx_resources(adapter);
>                 ixgbevf_clear_interrupt_scheme(adapter);
> -               rtnl_unlock();
>         }
> +       rtnl_unlock();
>
>  #ifdef CONFIG_PM
>         retval = pci_save_state(pdev);
> @@ -4199,8 +4206,12 @@ static void ixgbevf_remove(struct pci_dev *pdev)
>         if (netdev->reg_state == NETREG_REGISTERED)
>                 unregister_netdev(netdev);

So this line here should be what takes care of unregistering the
netdev.  It will take care of the rtnl_lock/unlock calls for you and
call close.

> -       ixgbevf_clear_interrupt_scheme(adapter);
> -       ixgbevf_reset_interrupt_capability(adapter);
> +       rtnl_lock();
> +       if (netif_device_present(netdev)) {
> +               ixgbevf_clear_interrupt_scheme(adapter);
> +               ixgbevf_reset_interrupt_capability(adapter);
> +       }
> +       rtnl_unlock();

This is a definite nack.  We should always be calling these in the
cleanup routine even if the network device is not present.

The funny thing is that based on the setup it looks like some
redundancy is okay with these calls.  It looks like
ixgbevf_clear_interrupt_scheme calls
ixgbevf_reset_interrupt_capability.  So calling the
ixgbevf_reset_interrupt_capability more than once must have no effect.

The one thing I might change is to add a check for NULL to
ixgbevf_free_q_vectors.  It doesn't look like that function could
handle us calling it more than once.  Other than that the rest of this
is fine to leave it as is.

The key bits are that while the netdev is present we have to rely on
the rtnl_lock, once it is gone then the PCI device lock should keep us
from doing multiple things on the same device at the same time.  The
only thing we have to make sure of is that if we call
ixgbevf_clear_interrupt_scheme in suspend that we can call it in
remove without causing a NULL pointer deference.

Thanks.

- Alex
