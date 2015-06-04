From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Thu, 04 Jun 2015 13:34:46 -0700
Subject: [Intel-wired-lan] vlan packet handling in ixgbevf driver when
 in	promiscuous mode
In-Reply-To: <5570998C.60600@windriver.com>
References: <5568D344.9090903@windriver.com>
 <C5551D9AAB213A418B7FD5E4A6F30A078930269A@ORSMSX108.amr.corp.intel.com>
 <556CF268.2060703@windriver.com>
 <C5551D9AAB213A418B7FD5E4A6F30A0789304FA1@ORSMSX108.amr.corp.intel.com>
 <5570998C.60600@windriver.com>
Message-ID: <5570B666.3030603@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06/04/2015 11:31 AM, Chris Friesen wrote:
> On 06/04/2015 09:54 AM, Rose, Gregory V wrote:
>>> -----Original Message----- From: Chris Friesen
>>> [mailto:chris.friesen at windriver.com] Sent: Monday, June 01, 2015 
>>> 5:02 PM
>>> To: Rose, Gregory V; intel-wired-lan at lists.osuosl.org Subject: Re:
>>> [Intel-wired-lan] vlan packet handling in ixgbevf driver when in
>>> promiscuous mode
>>>
>>> Could you elaborate?
>>>
>>> The use-case here is for NFV/SDN type stuff, where we want to be 
>>> able to
>>> run a router or something similar in the guest--so it needs to be 
>>> able to
>>> receive packets from all VLANs.
>>>
>>> From what I see if you enable promiscuous mode on the PF then the 
>>> VFs get
>>> packets from all VLANs.
>
>> If you have a working configuration then that's fine.  I was merely 
>> pointing
>> out that promiscuous mode, as the semantics are commonly applied to 
>> word in a
>> networking context, is not supported for virtual functions on the 82599
>> controller.  There are configurations you can apply to suit your own 
>> purposes
>> and we would like to support that for you if we can.
>
> Well, it's "working" but it means we have to patch the ixgbevf driver, 
> which is a bit of a pain.
>
> I'd like to see something like what Alexander Duyck suggested where 
> the stock ixgbevf driver would only strip the VLAN tags off for 
> packets where the VLAN matches the port VLAN ID and let all the other 
> VLAN tags through.  (If the guest interface is in promiscuous mode.)
>
> Arguably if the guest interface is not in promiscuous mode then I 
> think we should be dropping packets from all VLANs other than what the 
> guest has explicitly registered for (or that the PF has assigned to 
> the VF.  It makes no sense to me that we would let them all through 
> but strip off the VLAN header.
>
> Chris

Chris,

Based on what is in current net-next I don't see how you can enable VLAN 
promiscuous mode on the PF without having a modified driver of some 
sort.  That is the first issue.  That is the one we have been discussing 
with Hiroshi as he had submitted patches to enable such a feature.

That is what leads us to your request.  If you enable VLAN promiscous 
the VF drivers currently don't support it and generally make a mess of 
things since this misidentify the VLAN ID on the incoming frames.  So 
you would need to do two things.  The first would be to update the PF 
driver so that if VLAN promiscuous mode is enabled you turn off any 
legacy VFs that might be running.  The second would be to generate a new 
API version for the VF driver and add the necessary bits so that the VFs 
can identify which VLAN they are assigned to, if any.  We did something 
similar for Jumbo Frames and FCoE/DCB so that we could allow a PF to 
enable these features even though it caused some legacy VFs to crash if 
such a feature was enabled.  If you are wanting to enable VLAN 
promiscuous mode then that is the route you would like need to take.

- Alex
