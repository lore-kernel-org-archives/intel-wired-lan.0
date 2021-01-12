From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 12 Jan 2021 16:58:02 -0600
Subject: [Intel-wired-lan] [PATCH v2] PCI: Fix Intel i210 by avoiding
 overlapping of BARs
In-Reply-To: <642eb96b495f5ad7d2d14410fedcd1ad@walle.cc>
Message-ID: <20210112225802.GA1859984@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Jan 09, 2021 at 07:31:46PM +0100, Michael Walle wrote:
> Hi Bjorn,
> 
> Am 2021-01-08 22:20, schrieb Bjorn Helgaas:
> > On Wed, Dec 30, 2020 at 07:53:17PM +0100, Michael Walle wrote:
> > > The Intel i210 doesn't work if the Expansion ROM BAR overlaps with
> > > another BAR. Networking won't work at all and once a packet is sent
> > > the
> > > netdev watchdog will bite:
> > 
> > 1) Is this a regression?  It sounds like you don't know for sure
> > because earlier kernels don't support your platform.
> 
> Whats the background of the question? The board is offially supported
> since 5.8. I doubt that the code responsible to not touch the ExpROM
> BAR in pci_std_update_resource() were recently changed/added; the
> comment refers to a mail from 2005. So no I don't think it is a
> regression per se.

Just asking because it affects the urgency.  If we added a regression
during the v5.11 merge window, we'd try hard to fix it before
v5.11-final.  But it sounds like the problem has been there a long
time, so a fix could wait until v5.12.

> It is just that some combination of hardware and firmware will program
> the BARs in away so that this bug is triggered. And chances of this
> happing are very unlikely.
> 
> Do we agree that it should be irrelevant how the firmware programs and
> enables the BARs in this case? I.e. you could "fix" u-boot to match the
> way linux will assign addresses to the BARs. But that would just work
> around the real issue here. IMO.

I agree, Linux should work correctly regardless of how firmware
programmed the BARs.

> > 2) Can you open a bugzilla at https://bugzilla.kernel.org and attach
> > the complete dmesg and "sudo lspci -vv" output?  I want to see whether
> > Linux is assigning something incorrectly or this is a consequence of
> > some firmware initialization.
> 
> Sure, but you wouldn't even see the error with "lspci -vv" because
> lspci will just show the mapping linux assigned to it. But not whats
> written to the actual BAR for the PCI card. I'll also include a
> "lspci -xx". I've enabled CONFIG_PCI_DEBUG, too.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=211105
> 
> > 3) If the Intel i210 is defective in how it handles an Expansion ROM
> > that overlaps another BAR, a quirk might be the right fix. But my
> > guess is the device is working correctly per spec and there's
> > something wrong in how firmware/Linux is assigning things.  That would
> > mean we need a more generic fix that's not a quirk and not tied to the
> > Intel i210.
> 
> Agreed, but as you already stated (and I've also found that in the PCI
> spec) the Expansion ROM address decoder can be shared by the other BARs
> and it shouldn't matter as long as the ExpROM BAR is disabled, which is
> the case here.

My point is just that if this could theoretically affect devices other
than the i210, the fix should not be an i210-specific quirk.

I'll assume this is a general problem and wait for a generic PCI core
solution unless it's i210-specific.

Bjorn
