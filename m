From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 17 Aug 2018 16:19:50 -0700
Subject: [Intel-wired-lan] [PATCH next-queue 0/8] ixgbe/ixgbevf: IPsec
 offload support for VFs
In-Reply-To: <7796a29d-625a-4728-defd-cda73afc83ba@oracle.com>
References: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UdcijJ4f4gKeHj6t_EGuKjE7P5oZ0UH0_jfuHQ05RJALA@mail.gmail.com>
 <5ff4527d-7557-10f4-f41e-3e618f0e5863@oracle.com>
 <CAKgT0UfjB35yWMALtLUh-dU78VUW95=8MMn8rLcnKiTQxOB-Eg@mail.gmail.com>
 <7796a29d-625a-4728-defd-cda73afc83ba@oracle.com>
Message-ID: <84477537-900a-fb3b-50fa-8142bba76869@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 8/16/2018 2:36 PM, Shannon Nelson wrote:
> On 8/16/2018 2:15 PM, Alexander Duyck wrote:
>> On Tue, Aug 14, 2018 at 10:10 AM Shannon Nelson
>> <shannon.nelson@oracle.com> wrote:
>>>
>>> On 8/14/2018 8:30 AM, Alexander Duyck wrote:
>>>> On Mon, Aug 13, 2018 at 11:43 AM Shannon Nelson
>>>> <shannon.nelson@oracle.com> wrote:
>>>>>
>>>>> This set of patches implements IPsec hardware offload for VF 
>>>>> devices in
>>>>> Intel's 10Gbe x540 family of Ethernet devices.
>>>
>>> [...]
>>>
>>>>
>>>> So the one question I would have about this patch set is what happens
>>>> if you are setting up a ipsec connection between the PF and one of the
>>>> VFs on the same port/function? Do the ipsec offloads get translated
>>>> across the Tx loopback or do they end up causing issues? Specifically
>>>> I would be interested in seeing the results of a test either between
>>>> two VFs, or the PF and one of the VFs on the same port.
>>>>
>>>> - Alex
>>>>
>>>
>>> There is definitely something funky in the internal switch connection,
>>> as messages going from PF to VF with an offloaded encryption don't seem
>>> to get received by the VF, at least when in a VEB setup.? If I only set
>>> up offloads on the Rx on both PF and VF, and don't offload the Tx, then
>>> things work.
>>>
>>> I don't have a setup to test this, but I suspect that in a VEPA
>>> configuration, with packets going out to the switch and turned around
>>> back in, the Tx encryption offload would happen as expected.
>>>
>>> sln
>>
>> We should probably look at adding at least one patch to the set then
>> that disables IPsec Tx offload if SR-IOV is enabled with VEB so that
>> we don't end up breaking connections should a VF be migrated from a
>> remote system to a local one that it is connected to.
>>
>> - Alex
>>
> 
> The problem with this is that someone could set up an IPsec connection 
> on the PF for Tx and Rx use, then set num_vfs, start some VFs, and we 
> still can end up in the same place.? I don't think we want to disallow 
> all Tx IPsec offload.
> 
> Maybe we can catch it in ixgbe_ipsec_offload_ok()?? If it can find that 
> the dest mac is on the internal switch, perhaps it can NAK the Tx 
> offload?? That would force the XFRM xmit code to do a regular SW encrypt 
> before sending the packet.? I'll look into this.
> 
> sln

This would be a great idea, but the xdo_state_offload_ok() callback 
happens in the network stack before routing has happened, so there is no 
mac address yet in the skb.  We may be stuck with NAKing *all* Tx 
offloads when num_vfs != 0.  It works, and it is better than no offload 
at all, but it sure harshes the vibe.  Blech.

sln

