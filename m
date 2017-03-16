From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Mar 2017 20:13:40 +0000
Subject: [Intel-wired-lan] [BUG] 4.11.0-rc1 panic on shutdown X61s
In-Reply-To: <20170314024033.GK802@shells.gnugeneration.com>
References: <20170312053723.GH802@shells.gnugeneration.com>
 <20170312115703.GA18197@nazgul.tnic> <20170312122621.GA2823@nazgul.tnic>
 <CAHp75Ve7SWivf=TTuq-qA=iM20E==OmSZD2YAmt0LVJQg47Osg@mail.gmail.com>
 <20170312222333.hm54nl2ul5iuixap@pd.tnic> <87shmhjfap.fsf@miraculix.mork.no>
 <309B89C4C689E141A5FF6A0C5FB2118B8C5B3F9B@ORSMSX101.amr.corp.intel.com>
 <20170314024033.GK802@shells.gnugeneration.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10402F44@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Tested this on a Thinkpad T420i, after verifying it also has an e1000e NIC, unable to  reproduce. Might be limited to that particular model/firmware version you're using, which I was not able to track down here although there is another person I could ask, might be able to come up with one yet.


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of lkml at pengaru.com
> Sent: Monday, March 13, 2017 7:41 PM
> To: Brown, Aaron F <aaron.f.brown@intel.com>
> Cc: vcaputo at pengaru.com; linux-pci at vger.kernel.org; David Singleton
> <davsingl@cisco.com>; linux-kernel <linux-kernel@vger.kernel.org>;
> khalidm <khalidm@cisco.com>; Andy Shevchenko
> <andy.shevchenko@gmail.com>; Borislav Petkov <bp@alien8.de>; intel-
> wired-lan at lists.osuosl.org; Bj?rn Mork <bjorn@mork.no>
> Subject: Re: [Intel-wired-lan] [BUG] 4.11.0-rc1 panic on shutdown X61s
> 
> On Tue, Mar 14, 2017 at 01:20:27AM +0000, Brown, Aaron F wrote:
> > > Borislav Petkov <bp@alien8.de> writes:
> > > > On Sun, Mar 12, 2017 at 03:55:08PM +0200, Andy Shevchenko wrote:
> > > >
> > > >> The only change that IMHO matters happened between v4.10 and
> > > >> v4.11-
> > > rc1 is this:
> > > >>
> > > >> @@ -6276,8 +6274,8 @@ static int e1000e_pm_freeze(struct device
> *dev)
> > > >>                 /* Quiesce the device without resetting the hardware */
> > > >>                 e1000e_down(adapter, false);
> > > >>                 e1000_free_irq(adapter);
> > > >> +               e1000e_reset_interrupt_capability(adapter);
> > > >>         }
> > > >> -       e1000e_reset_interrupt_capability(adapter);
> > > >>
> > > >> So, it apparently misses something for the other case, like
> > > >> pci_disable_msi() call or so.
> > > >
> > > > Well, lemme add the people from
> > > >
> > > >   7e54d9d063fa ("e1000e: driver trying to free already-free irq")
> > > >
> > > > to CC then. :-)
> > >
> > > Already did that a week ago:
> > > https://www.spinics.net/lists/netdev/msg423379.html
> > >
> > > Haven't heard anything back yet.  Wondering if they are waiting for
> > > someone else to submit the pretty obvious revert?  Don't understand
> > > why that should take more than a minute to figure out.  It's not
> > > like they are testing these changes anyway...
> >
> <snip>
> >
> > What exact part (or parts) are we looking at (lspci|grep -i eth) that trigger
> this?  Could it be a difference in .config files?  The trace says it is falling back
> to legacy interrupts, does the system continue to work and does the
> network continue to function in that mode?  In case it's related to user space
> what is the base distro?  Any other information you think can help me
> reproduce the issue would be appreciated.
> >
> 
> Config attached, the machine is a Thinkpad X61s 1.8Ghz with no onboard
> wireless devices (rtl8192cu usb wifi is used).
> 
> # lspci| grep -i eth
> 00:19.0 Ethernet controller: Intel Corporation 82566MM Gigabit Network
> Connection (rev 03)
> 
> Debian jessie amd64 is the distro.
> 
> I'll have to get back to you on if the e1000e continues functioning, the
> machine continues to function until the shutdown panic.
> 
> There were however some occurrences of subsequent suspend/resume
> cycles hanging the machine hard leaving the display off, which prompted me
> to resume using
> 4.10 before digging any further as it's my only system right now.
> 
> Will try get around to testing 4.11 with 7e54d9d063fa reverted soon.
> 
> Regards,
> Vito Caputo
