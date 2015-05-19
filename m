From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 19 May 2015 18:28:36 +0000
Subject: [Intel-wired-lan] [PATCH] pci: Use a bus-global mutex to
 protect VPD operations
In-Reply-To: <555B78F7.60908@redhat.com>
References: <20150519000037.56109.68356.stgit@mdrustad-wks.jf.intel.com>
 <555B78F7.60908@redhat.com>
Message-ID: <E9012788-257F-4C44-B7F1-789B94423924@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On May 19, 2015, at 10:55 AM, Alexander Duyck <alexander.h.duyck@redhat.com> wrote:
> 
> On 05/18/2015 05:00 PM, Mark D Rustad wrote:
>> Some devices have a problem with concurrent VPD access to different
>> functions of the same physical device, so move the protecting mutex
>> from the pci_vpd structure to the pci_bus structure. There are a
>> number of reports on support sites for a variety of devices from
>> various vendors getting the "vpd r/w failed" message. This is likely
>> to at least fix some of them. Thanks to Shannon Nelson for helping
>> to come up with this approach.
>> 
>> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
>> Acked-by: Shannon Nelson <shannon.nelson@intel.com>
>> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> 
> Instead of moving the mutex lock around you would be much better served by simply removing the duplicate VPD entries for a given device in a PCIe quirk.  Then you can save yourself the extra pain and effort of having to deal with serialized VPD accesses for a multifunction device.
> 
> The logic for the quirk should be fairly simple.
>  1.  Scan for any other devices with VPD that share the same bus and device number.
>  2.  If bdf is equal to us keep searching.
>  3.  If bdf is less than our bdf we release our VPD area and set VPD pointer to NULL.

I could do that. If this issue only affected Intel devices, I would be more inclined to consider something like that. I am avoiding discussing other vendors directly, so please go and do a Google search on "vpd r/w failed" and see if you really want to quirk all those devices. It isn't just Intel and it isn't just networking.

If after doing that you still feel that this isn't the best solution, I can go and cook up something much bigger (I already had two much bigger patches that I abandoned in favor of this approach). Bear in mind that the quirk code is dead weight in all the kernels.

As you said in another message, VPD is not that vital. Given that, I would think that some possible needless synchronization that resolves real problems for many devices should be acceptable. If it was synchronizing all config space or something that would be different, but this is just VPD.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150519/9d559406/attachment-0001.asc>
