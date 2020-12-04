From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 4 Dec 2020 14:38:03 -0800
Subject: [Intel-wired-lan] [PATCH v3 0/7] Improve s0ix flows for systems
 i219LM
In-Reply-To: <DM6PR19MB2636B200D618A5546E7BBB57FAF10@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201204200920.133780-1-mario.limonciello@dell.com>
 <CAKgT0Uc=OxcuHbZihY3zxsxzPprJ_8vGHr=reBJFMrf=V9A5kg@mail.gmail.com>
 <DM6PR19MB2636B200D618A5546E7BBB57FAF10@DM6PR19MB2636.namprd19.prod.outlook.com>
Message-ID: <CAKgT0UfuyrbzpDNySMmnAkqKnw9cYuEM1LhgG0QvmrY=smR-uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Dec 4, 2020 at 2:28 PM Limonciello, Mario
<Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: Alexander Duyck <alexander.duyck@gmail.com>
> > Sent: Friday, December 4, 2020 15:27
> > To: Limonciello, Mario
> > Cc: Jeff Kirsher; Tony Nguyen; intel-wired-lan; LKML; Linux PM; Netdev; Jakub
> > Kicinski; Sasha Netfin; Aaron Brown; Stefan Assmann; David Miller; David
> > Arcari; Shen, Yijun; Yuan, Perry; anthony.wong at canonical.com
> > Subject: Re: [PATCH v3 0/7] Improve s0ix flows for systems i219LM
> >
> >
> > [EXTERNAL EMAIL]
> >
> > On Fri, Dec 4, 2020 at 12:09 PM Mario Limonciello
> > <mario.limonciello@dell.com> wrote:
> > >
> > > commit e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME
> > systems")
> > > disabled s0ix flows for systems that have various incarnations of the
> > > i219-LM ethernet controller.  This was done because of some regressions
> > > caused by an earlier
> > > commit 632fbd5eb5b0e ("e1000e: fix S0ix flows for cable connected case")
> > > with i219-LM controller.
> > >
> > > Performing suspend to idle with these ethernet controllers requires a
> > properly
> > > configured system.  To make enabling such systems easier, this patch
> > > series allows determining if enabled and turning on using ethtool.
> > >
> > > The flows have also been confirmed to be configured correctly on Dell's
> > Latitude
> > > and Precision CML systems containing the i219-LM controller, when the kernel
> > also
> > > contains the fix for s0i3.2 entry previously submitted here and now part of
> > this
> > > series.
> > > https://marc.info/?l=linux-netdev&m=160677194809564&w=2
> > >
> > > Patches 4 through 7 will turn the behavior on by default for some of Dell's
> > > CML and TGL systems.
> >
> > The patches look good to me. Just need to address the minor issue that
> > seems to have been present prior to the introduction of this patch
> > set.
> >
> > Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
>
> Thanks for your review.  Just some operational questions - since this previously
> existed do you want me to re-spin the series to a v4 for this, or should it be
> a follow up after the series?
>
> If I respin it, would you prefer that change to occur at the start or end
> of the series?

I don't need a respin, but if you are going to fix it you should
probably put out the patch as something like a 8/7. If you respin it
should happen near the start of the series as it is a bug you are
addressing.
