From: Michael Walle <michael@walle.cc>
Date: Mon, 01 Feb 2021 20:49:16 +0100
Subject: [Intel-wired-lan] [PATCH v2] PCI: Fix Intel i210 by avoiding
 overlapping of BARs
In-Reply-To: <2477c66eafbd97207693b83b60fa0a3c@walle.cc>
References: <20210115235721.GA1862880@bjorn-Precision-5520>
 <2477c66eafbd97207693b83b60fa0a3c@walle.cc>
Message-ID: <e8647a2cd4bfbcd42c27183d1c8984a0@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Bjorn,

Am 2021-01-17 20:27, schrieb Michael Walle:
> Am 2021-01-16 00:57, schrieb Bjorn Helgaas:
>> On Wed, Jan 13, 2021 at 12:32:32AM +0100, Michael Walle wrote:
>>> Am 2021-01-12 23:58, schrieb Bjorn Helgaas:
>>> > On Sat, Jan 09, 2021 at 07:31:46PM +0100, Michael Walle wrote:
>>> > > Am 2021-01-08 22:20, schrieb Bjorn Helgaas:
>> 
>>> > > > 3) If the Intel i210 is defective in how it handles an Expansion ROM
>>> > > > that overlaps another BAR, a quirk might be the right fix. But my
>>> > > > guess is the device is working correctly per spec and there's
>>> > > > something wrong in how firmware/Linux is assigning things.  That would
>>> > > > mean we need a more generic fix that's not a quirk and not tied to the
>>> > > > Intel i210.
>>> > >
>>> > > Agreed, but as you already stated (and I've also found that in
>>> > > the PCI spec) the Expansion ROM address decoder can be shared by
>>> > > the other BARs and it shouldn't matter as long as the ExpROM BAR
>>> > > is disabled, which is the case here.
>>> >
>>> > My point is just that if this could theoretically affect devices
>>> > other than the i210, the fix should not be an i210-specific quirk.
>>> > I'll assume this is a general problem and wait for a generic PCI
>>> > core solution unless it's i210-specific.
>>> 
>>> I guess the culprit here is that linux skips the programming of the
>>> BAR because of some broken Matrox card. That should have been a
>>> quirk instead, right? But I don't know if we want to change that, do
>>> we? How many other cards depend on that?
>> 
>> Oh, right.  There's definitely some complicated history there that
>> makes me a little scared to change things.  But it's also unfortunate
>> if we have to pile quirks on top of quirks.
>> 
>>> And still, how do we find out that the i210 is behaving correctly?
>>> In my opinion it is clearly not. You can change the ExpROM BAR value
>>> during runtime and it will start working (while keeping it
>>> disabled).  Am I missing something here?
>> 
>> I agree; if the ROM BAR is disabled, I don't think it should matter at
>> all what it contains, so this does look like an i210 defect.
>> 
>> Would you mind trying the patch below?  It should update the ROM BAR
>> value even when it is disabled.  With the current pci_enable_rom()
>> code that doesn't rely on the value read from the BAR, I *think* this
>> should be safe even on the Matrox and similar devices.
> 
> Your patch will fix my issue:
> 
> Tested-by: Michael Walle <michael@walle.cc>

any news on this?

-michael
