From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 16 Aug 2016 13:39:53 -0700
Subject: [Intel-wired-lan] [next PATCH 1/5] i40e: Introduce devlink
	interface.
In-Reply-To: <57B3615B.6020504@intel.com>
References: <1470329387-25138-1-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0UeGtE2UUQWmjciz+zvLsCVPknvoUevmW6GRyDXMNCySSQ@mail.gmail.com>
 <57AB5B5B.3090801@gmail.com>
 <CAKgT0Ud5LYhKeyD7_fbw-SXFFi7hSTe8mCSUdj_=oXQv5m+AeA@mail.gmail.com>
 <57AB756D.1060600@gmail.com> <57B3615B.6020504@intel.com>
Message-ID: <CAKgT0Udm2H53qYupN3N-p5aD9NSdnVaAr8zq1OgcO6apeR4j9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 16, 2016 at 11:54 AM, Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
> On 8/10/2016 11:41 AM, John Fastabend wrote:
>>
>> On 16-08-10 11:18 AM, Alexander Duyck wrote:
>>>
>>> On Wed, Aug 10, 2016 at 9:50 AM, John Fastabend
>>> <john.fastabend@gmail.com> wrote:
>>>>
>>>> On 16-08-10 09:01 AM, Alexander Duyck wrote:
>>>>>
>>>>> On Thu, Aug 4, 2016 at 9:49 AM, Sridhar Samudrala
>>>>> <sridhar.samudrala@intel.com> wrote:
>>>>>>
>>>>>> Add initial devlink support to set/get the mode of SRIOV switch.
>>>>>> This patch allows the mode to be set to either 'legacy' or
>>>>>> 'switchdev', but
>>>>>> doesn't implement any functionality to create vf representors in
>>>>>> switchdev
>>>>>> mode.
>>>>>>
>>>>>> With smode support in iproute2 'devlink' utility, switch mode can be
>>>>>> set
>>>>>> and get via following commands.
>>>>>>
>>>>>>      # devlink dev smode pci/0000:05:00.0
>>>>>>      mode: legacy
>>>>>>      # devlink dev set pci/0000:05:00.0 smode switchdev
>>>>>>      # devlink dev smode pci/0000:05:00.0
>>>>>>      mode: switchdev
>>>>>>
>>>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>>>
>>>>> I really don't see much value in this patch.  If you are going to
>>>>> support SwitchDev then just do it.  Otherwise you are adding extra
>>>>> overhead for maintaining two different modes.
>>>>>
>>>>> I would recommend putting this series out to netdev as an RFC.
>>>>> Submitting it to intel-wired-lan is kind of pointless as the audience
>>>>> it to small to get any valuable review.
>
>
> As these patches have only changes to i40e driver, i didn't include netdev.
> Will do so when
> i submit v2.
>
>>>>>
>>>>> - Alex
>>>>
>>>> I argued at length about this already. Jiri and company wanted this flag
>>>> to push device in and out of this mode. Here we are just following the
>>>> already upstreamed and debated decision.
>>>
>>> Yeah, I started doing more research after reviewing this patch.  I see
>>> the idea behind it.  I think the issue if anything is that it seems
>>> like things are a bit backwards.  We probably should be enabling the
>>> SwitchDev bits first and then working on adding devlink knobs to
>>> disable things later.
>>>
>> Sure, although its not clear to me exactly which switchdev bits are
>> useful for an edge NIC like this. Getting switch ids is one thing
>> that will become useful when we enable multiple bridges.
>
>
> This patchset is not really adding any switchdev ops.  We are calling the
> mode in which the
> PF driver creates VF representors as SWITCHDEV mode (this is based on the
> netdev
> discussion of mellanox patches).
>
> Amritha has a patch to add switchdev ops to VF representor netdevs that
> enables returning
> switch id via switchdev_port_attr_get() op.
>
>>
>> Otherwise I don't see what l2 switchdev blocks are useful vs
>> just using the standard ndo op interfaces already in place when
>> working on a device without learning/aging/etc. The one thing
>> that I've never bothered to add is pushing "learned" rules down
>> into the hardware but I'm not convinced for most use cases this
>> is particularly interesting because you _should_ know in a managed
>> system what MAC addresses a VM/container/etc is allowed to use
>> ahead of time via libvirt or other mgmt stack. I haven't tested
>> the VLAN handling though so that needs to be looked at.
>>
>> And l3 switchdev routing may be interesting but its fairly
>> low on my priority list unless someone is really excited about it.
>>
>>>> This is less about switchdev and more about generating VF netdevs to
>>>> use with ip tools and friends.
>>>
>>> Right.  One of the issues I have with this patch set is that it seems
>>> to get things backwards.  They are making VFs appear that don't do
>>> much of anything and then trying to bolt on features after the fact.
>>> We probably need to focus on enabling the VF representation, and then
>>> providing the ability to switch them on and off.  Also I would argue
>>> that we should actually be enabling switch features such as FDB
>>> entries instead of trying to bolt on stuff like flow director which
>>> doesn't really apply to very many switches and isn't as likely to be
>>> used on a switch port.
>>
>> Fair enough. Organizing the patches better seems OK to me. I plan to
>> use the 'tc' offloaded mechanisms not the ethtool flow director
>> interface for virtual switch offloads.
>>
>>>> Another option would be to just always enable VF netdevs and have no
>>>> legacy mode at all. I think that would be fine it just depends on if
>>>> you think having extra netdevs around will confuse the stack at all.
>>>> It might create a few corner cases but one reasonable thing to do
>>>> would be to just fix those cases as they appear.
>>>
>>> I'd say we are better off starting out with them just enabled and then
>>> enabling the option to disable them after the fact.  If we are going
>>> to have this extra code floating around we should be defaulting it to
>>> enabled so that it is more likely to be used.  The legacy option
>>> should only really be there so we can turn this off if we don't want
>>> it.
>>>
>> Works for me.
>>
>
> OK.  If we all agree that 'creating VF netdevs' by default is the right way
> to go,  I will rearrange the
> patchset in the following order.
>    - Introduce VF representor netdevs (create VF netdevs by default when
> sr-iov VFs are enabled)
>    - enable ethtool stats on VF representors
>    - enable ntuple filters on VF representors

No NTUPLE filters.  This is not the way the community will want to do
this, and this is not how I want to do this.

The easy way to think of this is that NTUPLE is just an alias for Rx
network flow classification.  Now where are the VF representors
supposed to receive traffic from?  It is the Tx path of the VF.  So by
putting NTUPLE filters on the VF representors you are implying  you
can get in the Tx path for the VF for all traffic, and last I knew
that was not the case.  As such it makes no sense to do it this way.

>    - introduce devlink to enable the switch mode to be changed to 'legacy'
> (no VF netdevs)
>
> Thanks
> Sridhar

You have to think of the VF representors as switch ports.  They don't
actually represent the VFs.  So if you think about it a switch port
will only have a few real features.  You can control the VLAN
membership, tagged/untagged, what FDB entries are assigned to the
port, the link speed, if the link is up/down, etc.  So some of your
first steps might be to focus on the L1 and L2 type items.  So for
example you might see if we can do things like control the upper limit
of the MTU for the VF by controlling the MTU for the VF representor.
See if you can at least make it so that the MAC and VLAN values for
the VF show up as FDB entries for the VF representor and so forth.

- Alex
