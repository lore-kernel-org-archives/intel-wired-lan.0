From: Michael Walle <michael@walle.cc>
Date: Wed, 13 Jan 2021 00:32:32 +0100
Subject: [Intel-wired-lan] [PATCH v2] PCI: Fix Intel i210 by avoiding
 overlapping of BARs
In-Reply-To: <20210112225802.GA1859984@bjorn-Precision-5520>
References: <20210112225802.GA1859984@bjorn-Precision-5520>
Message-ID: <3b101fff85ec1c490e9a14305a999cbe@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Am 2021-01-12 23:58, schrieb Bjorn Helgaas:
> On Sat, Jan 09, 2021 at 07:31:46PM +0100, Michael Walle wrote:
>> Hi Bjorn,
>> 
>> Am 2021-01-08 22:20, schrieb Bjorn Helgaas:
>> > On Wed, Dec 30, 2020 at 07:53:17PM +0100, Michael Walle wrote:
>> > > The Intel i210 doesn't work if the Expansion ROM BAR overlaps with
>> > > another BAR. Networking won't work at all and once a packet is sent
>> > > the
>> > > netdev watchdog will bite:
>> >
>> > 1) Is this a regression?  It sounds like you don't know for sure
>> > because earlier kernels don't support your platform.
>> 
>> Whats the background of the question? The board is offially supported
>> since 5.8. I doubt that the code responsible to not touch the ExpROM
>> BAR in pci_std_update_resource() were recently changed/added; the
>> comment refers to a mail from 2005. So no I don't think it is a
>> regression per se.
> 
> Just asking because it affects the urgency.  If we added a regression
> during the v5.11 merge window, we'd try hard to fix it before
> v5.11-final.  But it sounds like the problem has been there a long
> time, so a fix could wait until v5.12.

Yeah sure.

[..]

>> > 3) If the Intel i210 is defective in how it handles an Expansion ROM
>> > that overlaps another BAR, a quirk might be the right fix. But my
>> > guess is the device is working correctly per spec and there's
>> > something wrong in how firmware/Linux is assigning things.  That would
>> > mean we need a more generic fix that's not a quirk and not tied to the
>> > Intel i210.
>> 
>> Agreed, but as you already stated (and I've also found that in the PCI
>> spec) the Expansion ROM address decoder can be shared by the other 
>> BARs
>> and it shouldn't matter as long as the ExpROM BAR is disabled, which 
>> is
>> the case here.
> 
> My point is just that if this could theoretically affect devices other
> than the i210, the fix should not be an i210-specific quirk.
> I'll assume this is a general problem and wait for a generic PCI core
> solution unless it's i210-specific.

I guess the culprit here is that linux skips the programming of the BAR
because of some broken Matrox card. That should have been a quirk 
instead,
right? But I don't know if we want to change that, do we? How many other
cards depend on that?

And still, how do we find out that the i210 is behaving correctly? In
my opinion it is clearly not. You can change the ExpROM BAR value
during runtime and it will start working (while keeping it disabled).
Am I missing something here?

-michael
