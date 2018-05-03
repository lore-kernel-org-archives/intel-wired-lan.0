From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 3 May 2018 06:20:07 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: release lock for the
 duration of ixgbe_suspend_close()
In-Reply-To: <20180503035931.22439-2-pasha.tatashin@oracle.com>
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
 <20180503035931.22439-2-pasha.tatashin@oracle.com>
Message-ID: <CAKgT0UdocfEm9oXZ1dkEMari8m3OA4uVTrYg45uj9fk2V41bxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, May 2, 2018 at 8:59 PM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
> Currently, during device_shutdown() ixgbe holds rtnl_lock for the duration
> of lengthy ixgbe_close_suspend(). On machines with multiple ixgbe cards
> this lock prevents scaling if device_shutdown() function is multi-threaded.
>
> It is not necessary to hold this lock during ixgbe_close_suspend()
> as it is not held when ixgbe_close() is called also during shutdown but for
> kexec case.
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index afadba99f7b8..e7875b58854b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -6748,8 +6748,15 @@ static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
>         rtnl_lock();
>         netif_device_detach(netdev);
>
> -       if (netif_running(netdev))
> +       if (netif_running(netdev)) {
> +               /* Suspend takes a long time, device_shutdown may be
> +                * parallelized this function, so drop lock for the
> +                * duration of this call.
> +                */
> +               rtnl_unlock();
>                 ixgbe_close_suspend(adapter);
> +               rtnl_lock();
> +       }
>
>         ixgbe_clear_interrupt_scheme(adapter);
>         rtnl_unlock();

I'm not a fan of dropping the mutex while we go through
ixgbe_close_suspend. I'm concerned it will result in us having a
number of races on shutdown.

If anything, I think we would need to find a replacement for the mutex
that can operate at the per-netdev level if you are wanting to
parallelize this.

- Alex
