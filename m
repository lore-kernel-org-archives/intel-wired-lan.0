From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 15 Sep 2021 17:32:18 -0500
Subject: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
In-Reply-To: <1eba46af-e9d1-36aa-4bb7-9968b92a932f@twofifty.com>
Message-ID: <20210915223218.GA1542966@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 15, 2021 at 09:16:47AM -0700, Hisashi T Fujinaka wrote:
> On Wed, 15 Sep 2021, Heiner Kallweit wrote:
> > On 15.09.2021 16:18, Hisashi T Fujinaka wrote:
> > > On Tue, 14 Sep 2021, Heiner Kallweit wrote:
> > > > On 14.09.2021 22:00, Hisashi T Fujinaka wrote:

> > > > > I have confirmation that this should be a valid image. The
> > > > > VPD is just a series of 3's. There are changes to preboot
> > > > > header, flash and BAR size, and as far as I can tell, a
> > > > > nonsense subdevice ID, but this should work.
> > > > > 
> > > > > What was the original question?
> > > > > 
> > > > "lspci -vv" complains about an invalid short tag 0x06 and the
> > > > PCI VPD code resulted in a stall. So it seems the data doesn't
> > > > have valid VPD format as defined in PCI specification.
> > > > 
> > > > 01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
> > > >        Subsystem: Device 1dcf:030a
> > > >     ...
> > > >             Capabilities: [e0] Vital Product Data
> > > >                *Unknown small resource type 06, will not decode more.*
> > > > 
> > > > Not sure which method is used by the driver to get the EEPROM
> > > > content.  For the issue here is relevant what is exposed via
> > > > PCI VPD.
> > > > 
> > > > The related kernel error message has been reported few times,
> > > > e.g. here: https://access.redhat.com/solutions/3001451 Only
> > > > due to a change in kernel code this became a more prominent
> > > > issue now.
> > > > 
> > > > You say that VPD is just a series of 3's. This may explain why
> > > > kernel and tools complain about an invalid VPD format. VPD
> > > > misses the tag structure.
> > > 
> > > I think I conflated two issues and yours may not be the one with the
> > > weird Amazon NIC. In any case, the VPD does not match the spec and two
> > > people have confirmed it's just full of 3's. With the bogus subvendor
> > > ID, I'm thinking this is not an Intel NIC.

A series of 0x03 0x03 0x03 ... bytes would decode as "small items of
type 00", so I assume the VPD contains a series of 0x33 0x33 0x33 ...
bytes.  That would decode to a series of "small items of type 06",
each of length four (one byte for the tag, three bytes of data).

Prior to v5.15, we would complain "invalid short VPD tag 06" and stop
reading.  As of v5.15, I think we'll just keep reading looking for a
valid "end" tag, but we'll never find one.

I think in v5.15 there will be no error message because the series of
four-byte small data items happens to fit exactly in the maximum 32KB
size of VPD and is technically legal syntactic structure, even though
it makes no sense.

But it will be much slower and might account for the boot slowdown
Dave reported.

> > In an earlier mail in this thread was stated that subvendor id is unknown.
> > Checking here https://pcisig.com/membership/member-companies?combine=1dcf
> > it says: Beijing Sinead Technology Co., Ltd.
> 
> Huh. I didn't realize there was an official list beyond pciids.ucw.cz.
> 
> In any case, that's who you need to talk to about the unlisted (to
> Linux) vendor ID and also the odd VPD data.

https://pci-ids.ucw.cz/ is definitely unofficial in the sense that it
is basically crowd-sourced data, not the "official" Vendor IDs
controlled by the PCI SIG.

I submitted an addition to https://pci-ids.ucw.cz/

Bjorn
