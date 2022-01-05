From: John Garry <john.garry@huawei.com>
Date: Wed, 5 Jan 2022 17:42:16 +0000
Subject: [Intel-wired-lan] [RFC 01/32] Kconfig: introduce and depend on
 LEGACY_PCI
In-Reply-To: <e0877e91d7d50299ea5a3ffcee2cf1016458ce10.camel@linux.ibm.com>
References: <20211229160317.GA1681139@bhelgaas>
 <e0877e91d7d50299ea5a3ffcee2cf1016458ce10.camel@linux.ibm.com>
Message-ID: <3f39d8a2-2e57-a671-2926-eb4f2bf20c76@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 29/12/2021 16:55, Niklas Schnelle wrote:
> On Wed, 2021-12-29 at 10:03 -0600, Bjorn Helgaas wrote:
>> On Wed, Dec 29, 2021 at 01:12:07PM +0100, Mauro Carvalho Chehab wrote:
>>> Em Wed, 29 Dec 2021 12:45:38 +0100
>>> Niklas Schnelle<schnelle@linux.ibm.com>  escreveu:
>>>> ...
>>>> I do think we agree that once done correctly there is value in
>>>> such an option independent of HAS_IOPORT only gating inb() etc uses.
>> I'm not sure I'm convinced about this.  For s390, you could do this
>> patch series, where you don't define inb() at all, and you add new
>> dependencies to prevent compile errors.  Or you could define inb() to
>> return ~0, which is what happens on other platforms when the device is
>> not present.
>>
>>> Personally, I don't see much value on a Kconfig var for legacy PCI I/O
>>> space. From maintenance PoV, bots won't be triggered if someone use
>>> HAS_IOPORT instead of the PCI specific one - or vice-versa. So, we
>>> could end having a mix of both at the wrong places, in long term.
>>>
>>> Also, assuming that PCIe hardware will some day abandon support for
>>> "legacy" PCI I/O space, I guess some runtime logic would be needed,
>>> in order to work with both kinds of PCIe controllers. So, having a
>>> Kconfig option won't help much, IMO.
>>>
>>> So, my personal preference would be to have just one Kconfig var, but
>>> I'm ok if the PCI maintainers decide otherwise.
>> I don't really like the "LEGACY_PCI" Kconfig option.  "Legacy" just
>> means something old and out of favor; it doesn't say*what*  that
>> something is.
>>
>> I think you're specifically interested in I/O port space usage, and it
>> seems that you want all PCI drivers that*only*  use I/O port space to
>> depend on LEGACY_PCI?  Drivers that can use either I/O or memory
>> space or both would not depend on LEGACY_PCI?  This seems a little
>> murky and error-prone.
> I'd like to hear Arnd's opinion on this but you're the PCI maintainer
> so of course your buy-in would be quite important for such an option.
> 

Hi Niklas,

I can't see the value in the LEGACY_PCI config - however I don't really 
understand Arnd's original intention.

It was written that it would allow us to control "whether we have any 
pre-PCIe devices or those PCIe drivers that need PIO accessors other 
than ioport_map()/pci_iomap()".

However I just don't see why CONFIG_PCI=y and CONFIG_HAS_IOPORT=y aren't 
always the gating factor here. Arnd?

Thanks,
John
