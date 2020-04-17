From: Andrew Melnichenko <andrew@daynix.com>
Date: Fri, 17 Apr 2020 14:05:46 +0300
Subject: [Intel-wired-lan] Pls provide some advice - e1000e Linux link
 down
In-Reply-To: <CAKgT0Uc2w6gKGsUMrzDoTtM237DjVnQrUGhi+jARMKBcDBJu+g@mail.gmail.com>
References: <CABcq3pESeM2aF=HP-j4-iu2fwaxF7+mr65zTgFaBK8prmu+srw@mail.gmail.com>
 <61CC2BC414934749BD9F5BF3D5D940449863D544@ORSMSX112.amr.corp.intel.com>
 <CAKgT0Uc2w6gKGsUMrzDoTtM237DjVnQrUGhi+jARMKBcDBJu+g@mail.gmail.com>
Message-ID: <CABcq3pHBpCvNgZ3gw66-Lp+tKMPrKq8LN9M8r09_dFGOHymA5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>
> Definitely - LSC detected by watchdog.Should I look more the driver?
>
 Does this watchdog work during link up to detect link down?

Please, try work with latest stable version from kernel.org. (any
> restrictions?)

I've checked the issue on 4.18 and 5.5.6.

What do you mean that QEMU cannot raise LSC interrupts?
>
Interrupt pending hasn't been cleared, so it can't be raised again.

If you could include the code form your "fix"
>
Ok.


On Fri, Apr 17, 2020 at 12:21 AM Alexander Duyck <alexander.duyck@gmail.com>
wrote:

> On Thu, Apr 16, 2020 at 9:16 AM Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com> wrote:
> >
> > > From: Andrew Melnichenko <andrew@daynix.com>
> > > Sent: Saturday, April 11, 2020 12:56
> > > To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> > > Subject: Pls provide some advice - e1000e Linux link down
> > >
> > > Yo,
> > > I'm a humble linux developer, currently I'm researching the issue with
> e1000e driver that can't handle "link down" on Linux guest(
> https://bugzilla.redhat.com/show_bug.cgi?id=1707441).
> > > For now I've found that qemu can't raise LSC interrupts. But, on
> Windows guests the issue doesn't reproduce.
>
> What do you mean that QEMU cannot raise LSC interrupts? Looking over
> the latest QEMU code it looks like it is attempting to do just that in
> e1000e_core_set_link_status(
> https://lxr.missinglinkelectronics.com/qemu+v4.0.0/hw/net/e1000e_core.c#L1800
> ).
>
> > > I've researched spec and the driver and for now, my main suspicion is
> still the issue in qemu and I have few hacks for "fixing".
> > > But because on Windows guests that issue wasn't reproduced and I don't
> have a "real" device - I have a question:
> > > Does "real" e1000e with Linux driver detect cable removing? Should I
> look more the driver?
> > > Currently I have one hack for the driver that would "fix" the
> issue(small differences in interrupt clearing).
> >
> > Adding the e1000e developers and the Intel Wired LAN mailing list...
>
> So the fact that you need to hack on the interrupt clearing tells me
> that odds are you probably don't have a good emulation of the
> interrupt register behavior. We have had to make a number of changes
> to that code to work around the quirks in the hardware. I wouldn't
> find it too surprising if the emulation behavior didn't match up just
> because there have been a number of errata that have had to be work
> around.
>
> If you could include the code form your "fix" that might be useful as
> that would tell us what behavior it is you are running into that needs
> to be sorted out between QEMU and the hardware.
>
> Thanks.
>
> - Alex
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200417/5ed57ca0/attachment.html>
