From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Fri, 6 Jan 2017 11:09:12 +0200
Subject: [Intel-wired-lan] [net-next PATCH 5/6] i40e: Add TX and RX
	support in switchdev mode.
In-Reply-To: <586EC996.9080205@intel.com>
References: <1483078863-22026-1-git-send-email-sridhar.samudrala@intel.com>
 <1483078863-22026-6-git-send-email-sridhar.samudrala@intel.com>
 <CAJ3xEMgDAUSE2gVD3dU4UuXFb7k_W-9QgHpg-0c7b5kxRC2=FQ@mail.gmail.com>
 <586693A6.5090105@intel.com>
 <CAJ3xEMjGuKKge+_hqZPOg2fp3f50TdxGtbKFXwnCZ70rPxmuyw@mail.gmail.com>
 <586D7B4E.2010308@intel.com>
 <CAJ3xEMgAaXNbvaP0=GcuTsVOOGwPHuSMQf-SeLKpxB8WrbEvng@mail.gmail.com>
 <586EC996.9080205@intel.com>
Message-ID: <CAJ3xEMig+Hg1Dj2ebGBsb5ALW+M9jFobD=EcpcDz8qrccoNPEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 6, 2017 at 12:32 AM, Samudrala, Sridhar <
sridhar.samudrala@intel.com> wrote:

>
>
> On 1/5/2017 3:50 AM, Or Gerlitz wrote:
>
>> On Thu, Jan 5, 2017 at 12:46 AM, Samudrala, Sridhar
>> <sridhar.samudrala@intel.com> wrote:
>>
>>>
>>> On 1/3/2017 3:03 PM, Or Gerlitz wrote:
>>>
>>>> On Fri, Dec 30, 2016 at 7:04 PM, Samudrala, Sridhar
>>>> <sridhar.samudrala@intel.com> wrote:
>>>>
>>>>> On 12/30/2016 7:31 AM, Or Gerlitz wrote:
>>>>>
>>>>>> Are you exposing switchdev ops for the representators? didn't see that
>>>>>> or maybe it's in the 4th patch which didn't make it to the list?
>>>>>>
>>>>> Not at this time. In the future patches when we offload fdb/vlan
>>>>> functionality, we could use switchdev ops.
>>>>>
>>>> but wait, this is the switchdev mode... even before doing any
>>>> offloading, you want (need) your representor netdevices to have the
>>>> same HW ID marking they are all ports of the same ASIC, this you can
>>>> do with the switchdev parent ID attribute.
>>>>
>>> OK. I will add switchdev_port_attr_get() with PORT_PARENT_ID support in
>>> v3.
>>>
>> Good, I made this comment, b/c we want to create a well defined
>> user-experience
>> to be taken into account also by upper virtualization layers.
>>
>> Another piece there to add is have your VF reps implement the
>> get_phys_port_name ndo,
>>
>
> It looks like you are returning the VF port number as phys_port_name() for
> a VF rep in en_rep.c. ?s this correct?



yeah, correct, what we all call the VF rep actually represents the eswitch
vport the VF is connected to. The most flexible input for user space would
be just to get this port number along with the switchdev ID which tells
them to which switch this port belongs.


By default i am creating VFPR netdev with name as <pf_name>_VF<vf_num>
> For ex; if enp5s0f0 is the pf name, VFPR netdev for VF0 will be
> enp5s0f0_vf0
>
> If we want udev to follow this syntax should i return '_vf0'  as
> get_phys_port_name() for VF rep 0?


just return a number. Typically the PF is vport #0, so for vf0 you would
return 1, this is aligned with the kernel switchdev documentation [1]

Or.

[1]
http://lxr.free-electrons.com/source/Documentation/networking/switchdev.txt#L104
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170106/e9ef15b7/attachment-0001.html>
