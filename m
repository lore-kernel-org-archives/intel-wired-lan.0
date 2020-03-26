From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 26 Mar 2020 09:27:42 -0700
Subject: [Intel-wired-lan] [PATCH] igb: Use a sperate mutex insead of
 rtnl_lock()
In-Reply-To: <20200326103926.20888-1-kai.heng.feng@canonical.com>
References: <20200326103926.20888-1-kai.heng.feng@canonical.com>
Message-ID: <CAKgT0UfFnXcSSsXvxk8+xiZvyzDh+8V-9bCT-z5U+MEVoAVKLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 26, 2020 at 3:39 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Commit 9474933caf21 ("igb: close/suspend race in netif_device_detach")
> fixed race condition between close and power management ops by using
> rtnl_lock().
>
> This fix is a preparation for next patch, to prevent a dead lock under
> rtnl_lock() when calling runtime resume routine.
>
> However, we can't use device_lock() in igb_close() because when module
> is getting removed, the lock is already held for igb_remove(), and
> igb_close() gets called during unregistering the netdev, hence causing a
> deadlock. So let's introduce a new mutex so we don't cause a deadlock
> with driver core or netdev core.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

So this description doesn't make much sense to me. You describe the
use of the device_lock() in igb_close() but it isn't used there. In
addition it seems like you are arbitrarily moving code that was
wrapped in the rtnl_lock out of it. I'm not entirely sure that is safe
since there are calls within many of these functions that assume the
rtnl_lock is held and changing that is likely going to introduce more
issues.



> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index b46bff8fe056..dc7ed5dd216b 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -288,6 +288,8 @@ static const struct igb_reg_info igb_reg_info_tbl[] = {
>         {}
>  };
>
> +static DEFINE_MUTEX(igb_mutex);
> +
>  /* igb_regdump - register printout routine */
>  static void igb_regdump(struct e1000_hw *hw, struct igb_reg_info *reginfo)
>  {
> @@ -4026,9 +4028,14 @@ static int __igb_close(struct net_device *netdev, bool suspending)
>
>  int igb_close(struct net_device *netdev)
>  {
> +       int err = 0;
> +
> +       mutex_lock(&igb_mutex);
>         if (netif_device_present(netdev) || netdev->dismantle)
> -               return __igb_close(netdev, false);
> -       return 0;
> +               err = __igb_close(netdev, false);
> +       mutex_unlock(&igb_mutex);
> +
> +       return err;
>  }
>

Okay, so I am guessing the problem has something to do with the
addition of the netdev->dismantle test here and the fact that it is
bypassing the present check for the hotplug remove case?

So it looks like nobody ever really reviewed commit 888f22931478
("igb: Free IRQs when device is hotplugged"). What I would recommend
is reverting it and instead we fix the remaining pieces that need to
be addressed in igb so it more closely matches what we have in e1000e
after commit a7023819404a ("e1000e: Use rtnl_lock to prevent race
conditions between net and pci/pm"). From what I can tell the only
pieces that are really missing is to update igb_io_error_detected so
that in addition to igb_down it will call igb_free_irq, and then in
addition we should be wrapping most of the code in that function with
an rtnl_lock since it is detaching a device and making modifications
to it.
