From: Feng Tang <feng.tang@intel.com>
Date: Tue, 22 Jan 2019 09:40:29 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Make driver init async
In-Reply-To: <CAKgT0UdU3+bdnpHF3wGu+_zFCokJmQeFWKYrc+v+-MQPuTW37g@mail.gmail.com>
References: <1548059825-78171-1-git-send-email-feng.tang@intel.com>
 <CAKgT0UdU3+bdnpHF3wGu+_zFCokJmQeFWKYrc+v+-MQPuTW37g@mail.gmail.com>
Message-ID: <20190122014029.wrqvt3hfl3ee7g2x@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Duyck,

Thanks for your review!

On Mon, Jan 21, 2019 at 02:50:08PM -0800, Alexander Duyck wrote:
> On Mon, Jan 21, 2019 at 12:36 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > When optimizing boot time for a platform with igb module, we found the
> > igb driver probe will take about 45 ms, make the probe asynchronous
> > will save quite some time as the init runs in parallel with other
> > asynchronous drivers.
> >
> > In theory, this could be applied to some other drivers like igc or
> > e1000, but we don't have HW to verify that.
> >
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> I really don't like this patch. This seems like you are tuning for a
> specific platform or system setup by making changes to the driver. Is
> there any reason why you couldn't just pass the module parameter
> "igb.async_probe" to accomplish the same thing?

Thanks for the info. I didn't make it clear, in some case we need it to
be builtin, and this doesn't work per my try.

> I suspect most people
> won't care that much about the 45ms boot time difference, and if we

Yes, 45ms is trivial to Desktop/Server. But our platform is for automotive
and IOTG case, and these count there. US Department of Transportation
has a requirement that the rear-view camera needs to be functional in 2
seconds after power on. To achieve that, we've done things to get 20ms
from PCI init, 5ms from disabling some ACPI_PM clocksource :)

> were to make this sort of change it should probably be more
> generically applied to either PCI devices or network devices instead
> of doing this one driver at a time.

Agree. I also mentioned this in commit log, I didn't do it for other drivers
as I don't have HW to verify, and I would be happy to proceed if
experts for those HW think this change is fine.

Technically I think it's fine, as making them async will only push their
init later, which won't break their existing dependence. And there should
be very few modules which depend on network drivers.

Thanks,
Feng

> 
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > index 7137e7f..d477253 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -229,6 +229,7 @@ static struct pci_driver igb_driver = {
> >         .id_table = igb_pci_tbl,
> >         .probe    = igb_probe,
> >         .remove   = igb_remove,
> > +       .driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> >  #ifdef CONFIG_PM
> >         .driver.pm = &igb_pm_ops,
> >  #endif
> > --
> > 2.7.4
> >
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
