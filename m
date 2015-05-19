From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 19 May 2015 21:53:27 +0000
Subject: [Intel-wired-lan] [PATCH] pci: Use a bus-global mutex to
 protect VPD operations
In-Reply-To: <555BA3F0.5030001@redhat.com>
References: <20150519000037.56109.68356.stgit@mdrustad-wks.jf.intel.com>
 <555B78F7.60908@redhat.com> <E9012788-257F-4C44-B7F1-789B94423924@intel.com>
 <555BA3F0.5030001@redhat.com>
Message-ID: <DE578829-90CD-4CB0-A206-68A21D91AB0B@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On May 19, 2015, at 1:58 PM, Alexander Duyck <alexander.h.duyck@redhat.com> wrote:
> 
> I think you are assuming too much.  Have you root caused the other devices?

It is possible that you are right, but I think it is much more likely that this is a common design problem with many devices.

> All the "vpd r/w failed" means is that a given read or write timed out.  There are any number of possible reasons for that including VPD being unimplemented in firmware, a device falling off of the bus, and many others.  What you have is a common symptom, it doesn't mean it is a common ailment for all the other parts.

Yes, but it sure looks like many PCIe designers have shared the VPD registers across functions. It isn't just that the area they address is shared, it is that the register implementations are also shared across functions. That is the case with all the Intel devices (it is indicated in the datasheets) and I'm guessing that other designers have done the same thing. It is a guess at this point, but think it is a very good one.

>> If after doing that you still feel that this isn't the best solution, I can go and cook up something much bigger (I already had two much bigger patches that I abandoned in favor of this approach). Bear in mind that the quirk code is dead weight in all the kernels.
> 
> The quirk code is there to deal with buggy hardware implementations and that is what it sounds like you have in this case.  I highly doubt all of the other vendors implemented the same mistake.  If they did then maybe you should implement a the quirk as a new function that can be used by any of the devices that implement VPD with the same limitation.

Just the device table to list the affected devices, even if Intel is the only vendor with this issue, will be very much larger than this patch and every kernel will carry that weight.

>> As you said in another message, VPD is not that vital. Given that, I would think that some possible needless synchronization that resolves real problems for many devices should be acceptable. If it was synchronizing all config space or something that would be different, but this is just VPD.
> 
> The problem is it is needless synchronization, and it only resolves problems for some very specific devices.  The extra overhead for serializing what is already slow accesses can be very high so I am against it.

In any PCIe environment, it only serializes VPD access for one physical device's functions. That just isn't that bad.

> For example it will likely have unintended consequences on things like virtual machines where all direct assigned devices end up on the same bus.

Direct-assigned devices to virtual machines have problems here that I can't address. Hypervisors would have to be involved in resolving that problem, if it is important enough to do. At present I could only suggest that virtual machines should never access VPD at all. This is a problem. At least VFs, which are more commonly assigned to guests, do not have VPD.

Cutting off the VPD for non-zero functions will have consequences as well. Some may notice devices dropping out of their inventory. That can't be a good thing and could upset customers. I think that is a far larger problem with your approach. Arguably, that is a kernel interface change.

> We know that all Intel Ethernet parts to date only implement one VPD area per EEPROM, and that all functions in a multi-function Ethernet part share the same EEPROM, so the fix is to only present one VPD area so that the data is still there, without the ability of multiple access.  It seems like function 0 would be the obvious choice in that case so if somebody wants to be able to do their inventory they can go through and pull inventory information from function 0.  Really this is how this should have probably been implemented in the hardware in the first place if they couldn't support multiple accesses.

No argument from me there, but I don't have a time machine to go back and try to change the thinking on VPD. I'm sure it would take more gates to make the functions different, just as it would take more gates to do it right. Which is why I think the problem is as widespread as the Google results suggest.

Maybe I should send one of my big, ugly patches that only addresses the problem for Intel devices. This patch will look good in comparison.

Isn't getting rid of scary messages that upset customers worth something?

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150519/ee53da60/attachment.asc>
