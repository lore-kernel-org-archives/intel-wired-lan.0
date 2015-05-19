From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 19 May 2015 16:19:23 +0000
Subject: [Intel-wired-lan] [PATCH] pci: Limit VPD reads for all Intel
 Ethernet devices
In-Reply-To: <555B5CBF.1090902@redhat.com>
References: <20150519000042.56109.69779.stgit@mdrustad-wks.jf.intel.com>
 <555B5CBF.1090902@redhat.com>
Message-ID: <4AD84211-965C-4F0B-A7F4-3E6CCE6567E3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On May 19, 2015, at 8:54 AM, Alexander Duyck <alexander.h.duyck@redhat.com> wrote:
> 
> On 05/18/2015 05:00 PM, Mark D Rustad wrote:
>> To save boot time and some memory, limit VPD size to the maximum
>> possible for all Intel Ethernet devices that have VPD, which is 1K.
>> 
>> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
>> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>> ---
>>  drivers/pci/quirks.c |    7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index c6dc1dfd25d5..4fabbeda964a 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -1903,12 +1903,15 @@ static void quirk_netmos(struct pci_dev *dev)
>>  DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_NETMOS, PCI_ANY_ID,
>>  			 PCI_CLASS_COMMUNICATION_SERIAL, 8, quirk_netmos);
>>  -static void quirk_e100_interrupt(struct pci_dev *dev)
>> +static void quirk_intel_enet(struct pci_dev *dev)
>>  {
>>  	u16 command, pmcsr;
>>  	u8 __iomem *csr;
>>  	u8 cmd_hi;
>>  +	if (dev->vpd)
>> +		dev->vpd->len = 0x400;
>> +
>>  	switch (dev->device) {
>>  	/* PCI IDs taken from drivers/net/e100.c */
>>  	case 0x1029:

> I wasn't a fan of the first VPD patch and this clinches it.  What I would recommend doing is identifying all of the functions for a given device that share a VPD and then eliminate the VPD structure for all but the first function.  By doing that the OS should treat the other functions as though their VPD areas don't exist.

Please, lets discuss only *this* patch in this thread. The patches are not related except that they both have to do with VPD.

<snip>

> Artificially limiting the size of the VPD does nothing but cut off possibly useful data, you would be better of providing all of the data on only the first function than providing only partial data on all functions and adding extra lock overhead.

This limit only limits the maximum that the OS will read to what is architecturally possible in these devices. Yes, PCIe architecturally provides for the possibility of more, but these devices do not. More repeating data can be read, however slowly, but there is no possibility of useful content beyond the first 1K. If this limit were set to 0x100, which is more in line what the actual usage is, it would be an artificial limit, but at 1K it is not. Oh and it does include devices made by others that incorporate Intel Ethernet silicon, not just Intel-built devices.

Since this quirk function was already being run for every Intel Ethernet device, this seemed like a trivial thing to do to speed up booting a bit. It has the greatest effect with 82599 devices. Newer devices will respond to reads faster.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150519/c28e3930/attachment.asc>
