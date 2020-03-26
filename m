From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 26 Mar 2020 13:55:07 -0700
Subject: [Intel-wired-lan] [PATCH] igb: Use a sperate mutex insead of
 rtnl_lock()
In-Reply-To: <98E86E5A-4EE9-4CB5-81CF-49C3E74C3AE6@canonical.com>
References: <20200326103926.20888-1-kai.heng.feng@canonical.com>
 <CAKgT0UfFnXcSSsXvxk8+xiZvyzDh+8V-9bCT-z5U+MEVoAVKLw@mail.gmail.com>
 <98E86E5A-4EE9-4CB5-81CF-49C3E74C3AE6@canonical.com>
Message-ID: <CAKgT0UcigwjL10i4FReJqQip7zYgU4F5BEk1T-K824vPRRCmuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 26, 2020 at 10:16 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Alexander,
>
> > On Mar 27, 2020, at 00:27, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> >
> > On Thu, Mar 26, 2020 at 3:39 AM Kai-Heng Feng
> > <kai.heng.feng at canonical.com <mailto:kai.heng.feng@canonical.com>> wrote:
> >>
> >> Commit 9474933caf21 ("igb: close/suspend race in netif_device_detach")
> >> fixed race condition between close and power management ops by using
> >> rtnl_lock().
> >>
> >> This fix is a preparation for next patch, to prevent a dead lock under
> >> rtnl_lock() when calling runtime resume routine.
> >>
> >> However, we can't use device_lock() in igb_close() because when module
> >> is getting removed, the lock is already held for igb_remove(), and
> >> igb_close() gets called during unregistering the netdev, hence causing a
> >> deadlock. So let's introduce a new mutex so we don't cause a deadlock
> >> with driver core or netdev core.
> >>
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > So this description doesn't make much sense to me. You describe the
> > use of the device_lock() in igb_close() but it isn't used there.
>
> Sorry I forgot to add a revision number.
> It was used by previous version and Aaron found a regression when device_lock() is used.
>
> > In addition it seems like you are arbitrarily moving code that was
> > wrapped in the rtnl_lock out of it. I'm not entirely sure that is safe
> > since there are calls within many of these functions that assume the
> > rtnl_lock is held and changing that is likely going to introduce more
> > issues.
>
> The reason why rtnl lock needs to be removed is because of the following patch:
> https://lore.kernel.org/lkml/20200207101005.4454-2-kai.heng.feng at canonical.com/
>
> Ethtools helpers already held rtnl_lock, so to prevent a deadlock, my idea is to use another lock to solve what "igb: close/suspend race in netif_device_detach" originally tried to fix.

No offense, but that is a horrible reason to be removing the
rtnl_lock. It basically makes things worse since it is guaranteeing
the device can be in flux while you are trying to record the state of
the device.

Wouldn't it make more sense to check for pm_runtime_suspended and if
the interface is down and simply report SPEED_UNKNOWN rather than
trying to instrument the driver so that you can force it out of the
power management state to report statistics for an interface that we
know is already down?

> >
> > So it looks like nobody ever really reviewed commit 888f22931478
> > ("igb: Free IRQs when device is hotplugged"). What I would recommend
> > is reverting it and instead we fix the remaining pieces that need to
> > be addressed in igb so it more closely matches what we have in e1000e
> > after commit a7023819404a ("e1000e: Use rtnl_lock to prevent race
> > conditions between net and pci/pm"). From what I can tell the only
> > pieces that are really missing is to update igb_io_error_detected so
> > that in addition to igb_down it will call igb_free_irq, and then in
> > addition we should be wrapping most of the code in that function with
> > an rtnl_lock since it is detaching a device and making modifications
> > to it.
>
> In addition to that, igb_shutdown() indirectly calls igb_close() when netdev unregistering the device.

Yes, that is how it is supposed to be. We are modifying core state of
the netdevice and should only do so while holding the rtnl_lock.

> My "only scratch the surface" approach is because I don't have a reproducer for commit "igb: close/suspend race in netif_device_detach", and I am afraid of breaking it.
>
> Kai-Heng

This is taking things in the wrong direction. My advice is if you
cannot get reliable link information when the device is in a
pm_runtime_suspended state would be to simply test for that and report
the value out. Again, you can take a look at e1000e since it already
appears to be doing all this in e1000e_get_link_ksettings. We don't
need to have the drivers diverge from each other in solutions for
this. It is much easier to maintain if they can all be making use of
the same approach.

Thanks.

- Alex
