From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 21 Jan 2019 18:29:51 -0800
Subject: [Intel-wired-lan] [PATCH] igb: Make driver init async
In-Reply-To: <20190122014029.wrqvt3hfl3ee7g2x@shbuild888>
References: <1548059825-78171-1-git-send-email-feng.tang@intel.com>
 <CAKgT0UdU3+bdnpHF3wGu+_zFCokJmQeFWKYrc+v+-MQPuTW37g@mail.gmail.com>
 <20190122014029.wrqvt3hfl3ee7g2x@shbuild888>
Message-ID: <CAKgT0Uc14wOufpa2vspV6DZN-wF7QTqz2Te7QL7Ys06T8TMVkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jan 21, 2019 at 5:39 PM Feng Tang <feng.tang@intel.com> wrote:
>
> Hi Duyck,
>
> Thanks for your review!
>
> On Mon, Jan 21, 2019 at 02:50:08PM -0800, Alexander Duyck wrote:
> > On Mon, Jan 21, 2019 at 12:36 AM Feng Tang <feng.tang@intel.com> wrote:
> > >
> > > When optimizing boot time for a platform with igb module, we found the
> > > igb driver probe will take about 45 ms, make the probe asynchronous
> > > will save quite some time as the init runs in parallel with other
> > > asynchronous drivers.
> > >
> > > In theory, this could be applied to some other drivers like igc or
> > > e1000, but we don't have HW to verify that.
> > >
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> >
> > I really don't like this patch. This seems like you are tuning for a
> > specific platform or system setup by making changes to the driver. Is
> > there any reason why you couldn't just pass the module parameter
> > "igb.async_probe" to accomplish the same thing?
>
> Thanks for the info. I didn't make it clear, in some case we need it to
> be builtin, and this doesn't work per my try.

Well then why not try implementing a similar feature that could be
used for built-in drivers. My point is that it is really bad to be
modifying a driver to work for a specific use case. It makes the
driver overly brittle from a maintenance point of view.

> > I suspect most people
> > won't care that much about the 45ms boot time difference, and if we
>
> Yes, 45ms is trivial to Desktop/Server. But our platform is for automotive
> and IOTG case, and these count there. US Department of Transportation
> has a requirement that the rear-view camera needs to be functional in 2
> seconds after power on. To achieve that, we've done things to get 20ms
> from PCI init, 5ms from disabling some ACPI_PM clocksource :)

That is your set of requirements. There are multiple other users of
this driver out there. We cannot just go in and arbitrarily change
core behaviors for one specific use case. I would much prefer this to
be something that can be changed either via a sysctl or via a module
parameter so that we can have this behavior turned off by default if
so desired.

> > were to make this sort of change it should probably be more
> > generically applied to either PCI devices or network devices instead
> > of doing this one driver at a time.
>
> Agree. I also mentioned this in commit log, I didn't do it for other drivers
> as I don't have HW to verify, and I would be happy to proceed if
> experts for those HW think this change is fine.

You normally don't need to test all possible hardware that could be
impacted by a change, but what you should do is try to test what you
have available.

This sort of change would make more sense as a PCI feature where you
essentially cause endpoint devices to asynchronously probe instead of
doing so synchronously if a certain kernel module parameter is set.
Otherwise if you ever change drivers in the future for some design you
will have to submit yet another patch for this. So for example one
thing you might look at doing is adding a new option for the "pci="
module parameter. You could specify for example something like
"pci=async_probe=pci:8086:1533" and then that would specify all i210
adapters with that device ID would be asynchronously probed instead of
going through the standard probe path.

> Technically I think it's fine, as making them async will only push their
> init later, which won't break their existing dependence. And there should
> be very few modules which depend on network drivers.

Actually this will break functionality on the 82576 quad port
adapters. Specifically we are using a static counter to identify which
groupings of 4 ports belonged together using the global_quad_port_a
value. With this changing to asynchronous you will end up confusing
the driver resulting in it randomly assigning WOL to possibly the
wrong port since the async code doesn't guarantee ordering of the
probe routines.

That would be another good reason why this should be handled as a per
PCI device/function type feature instead of trying to just make it
apply to all of igb.

> Thanks,
> Feng
>

Thanks.

- Alex
