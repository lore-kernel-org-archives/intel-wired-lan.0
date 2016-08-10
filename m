From: John Fastabend <john.fastabend@gmail.com>
Date: Wed, 10 Aug 2016 11:41:49 -0700
Subject: [Intel-wired-lan] [next PATCH 1/5] i40e: Introduce devlink
 interface.
In-Reply-To: <CAKgT0Ud5LYhKeyD7_fbw-SXFFi7hSTe8mCSUdj_=oXQv5m+AeA@mail.gmail.com>
References: <1470329387-25138-1-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0UeGtE2UUQWmjciz+zvLsCVPknvoUevmW6GRyDXMNCySSQ@mail.gmail.com>
 <57AB5B5B.3090801@gmail.com>
 <CAKgT0Ud5LYhKeyD7_fbw-SXFFi7hSTe8mCSUdj_=oXQv5m+AeA@mail.gmail.com>
Message-ID: <57AB756D.1060600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-08-10 11:18 AM, Alexander Duyck wrote:
> On Wed, Aug 10, 2016 at 9:50 AM, John Fastabend
> <john.fastabend@gmail.com> wrote:
>> On 16-08-10 09:01 AM, Alexander Duyck wrote:
>>> On Thu, Aug 4, 2016 at 9:49 AM, Sridhar Samudrala
>>> <sridhar.samudrala@intel.com> wrote:
>>>> Add initial devlink support to set/get the mode of SRIOV switch.
>>>> This patch allows the mode to be set to either 'legacy' or 'switchdev', but
>>>> doesn't implement any functionality to create vf representors in switchdev
>>>> mode.
>>>>
>>>> With smode support in iproute2 'devlink' utility, switch mode can be set
>>>> and get via following commands.
>>>>
>>>>     # devlink dev smode pci/0000:05:00.0
>>>>     mode: legacy
>>>>     # devlink dev set pci/0000:05:00.0 smode switchdev
>>>>     # devlink dev smode pci/0000:05:00.0
>>>>     mode: switchdev
>>>>
>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>
>>> I really don't see much value in this patch.  If you are going to
>>> support SwitchDev then just do it.  Otherwise you are adding extra
>>> overhead for maintaining two different modes.
>>>
>>> I would recommend putting this series out to netdev as an RFC.
>>> Submitting it to intel-wired-lan is kind of pointless as the audience
>>> it to small to get any valuable review.
>>>
>>> - Alex
>>
>> I argued at length about this already. Jiri and company wanted this flag
>> to push device in and out of this mode. Here we are just following the
>> already upstreamed and debated decision.
> 
> Yeah, I started doing more research after reviewing this patch.  I see
> the idea behind it.  I think the issue if anything is that it seems
> like things are a bit backwards.  We probably should be enabling the
> SwitchDev bits first and then working on adding devlink knobs to
> disable things later.
> 

Sure, although its not clear to me exactly which switchdev bits are
useful for an edge NIC like this. Getting switch ids is one thing
that will become useful when we enable multiple bridges.

Otherwise I don't see what l2 switchdev blocks are useful vs
just using the standard ndo op interfaces already in place when
working on a device without learning/aging/etc. The one thing
that I've never bothered to add is pushing "learned" rules down
into the hardware but I'm not convinced for most use cases this
is particularly interesting because you _should_ know in a managed
system what MAC addresses a VM/container/etc is allowed to use
ahead of time via libvirt or other mgmt stack. I haven't tested
the VLAN handling though so that needs to be looked at.

And l3 switchdev routing may be interesting but its fairly
low on my priority list unless someone is really excited about it.

>> This is less about switchdev and more about generating VF netdevs to
>> use with ip tools and friends.
> 
> Right.  One of the issues I have with this patch set is that it seems
> to get things backwards.  They are making VFs appear that don't do
> much of anything and then trying to bolt on features after the fact.
> We probably need to focus on enabling the VF representation, and then
> providing the ability to switch them on and off.  Also I would argue
> that we should actually be enabling switch features such as FDB
> entries instead of trying to bolt on stuff like flow director which
> doesn't really apply to very many switches and isn't as likely to be
> used on a switch port.

Fair enough. Organizing the patches better seems OK to me. I plan to
use the 'tc' offloaded mechanisms not the ethtool flow director
interface for virtual switch offloads.

> 
>> Another option would be to just always enable VF netdevs and have no
>> legacy mode at all. I think that would be fine it just depends on if
>> you think having extra netdevs around will confuse the stack at all.
>> It might create a few corner cases but one reasonable thing to do
>> would be to just fix those cases as they appear.
> 
> I'd say we are better off starting out with them just enabled and then
> enabling the option to disable them after the fact.  If we are going
> to have this extra code floating around we should be defaulting it to
> enabled so that it is more likely to be used.  The legacy option
> should only really be there so we can turn this off if we don't want
> it.
> 

Works for me.


> - Alex
> 

