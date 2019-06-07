From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Fri, 7 Jun 2019 22:08:31 +0000
Subject: [Intel-wired-lan] [E1000-devel] i40e X722 RSS problem with
 NAT-Traversal IPsec packets
In-Reply-To: <alpine.NEB.2.21.9999.1906071343460.809@chris.i8u.org>
References: <20190516183705.e4zflbli7oujlbek@csclub.uwaterloo.ca>
 <CAKgT0UfSa-dM2+7xntK9tB7Zw5N8nDd3U1n4OSK0gbWbkNSKJQ@mail.gmail.com>
 <CAKgT0Ucd0s_0F5_nwqXknRngwROyuecUt+4bYzWvp1-2cNSg7g@mail.gmail.com>
 <20190517172317.amopafirjfizlgej@csclub.uwaterloo.ca>
 <CAKgT0UdM28pSTCsaT=TWqmQwCO44NswS0PqFLAzgs9pmn41VeQ@mail.gmail.com>
 <20190521151537.xga4aiq3gjtiif4j@csclub.uwaterloo.ca>
 <CAKgT0UfpZ-ve3Hx26gDkb+YTDHvN3=MJ7NZd2NE7ewF5g=kHHw@mail.gmail.com>
 <20190521175456.zlkiiov5hry2l4q2@csclub.uwaterloo.ca>
 <CAKgT0UcR3q1maBmJz7xj_i+_oux_6FQxua9DOjXQSZzyq6FhkQ@mail.gmail.com>
 <20190522143956.quskqh33ko2wuf47@csclub.uwaterloo.ca>
 <20190607143906.wgi344jcc77qvh24@csclub.uwaterloo.ca>
 <CAKgT0Ue1M8_30PVPmoJy_EGo2mjM26ecz32Myx-hpnuq_6wdjw@mail.gmail.com>
 <alpine.NEB.2.21.9999.1906071343460.809@chris.i8u.org>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD69AFBF090@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Just a quick update with the response I got and I'll make sure this is in our internal bug database.

Here's what I got back, and it looks like you guys have tried this already:

Have they tried these steps to configure RSS:

RSS Hash Flow
-------------

Allows you to set the hash bytes per flow type and any combination of one or
more options for Receive Side Scaling (RSS) hash byte configuration.

#ethtool -N <dev> rx-flow-hash <type> <option>

Where <type> is:
  tcp4  signifying TCP over IPv4
  udp4  signifying UDP over IPv4
  tcp6  signifying TCP over IPv6
  udp6  signifying UDP over IPv6
And <option> is one or more of:
  s Hash on the IP source address of the rx packet.
  d Hash on the IP destination address of the rx packet.
  f Hash on bytes 0 and 1 of the Layer 4 header of the rx packet.
  n Hash on bytes 2 and 3 of the Layer 4 header of the rx packet.

Also, looks like the driver needs to be updated to latest version:
>>> 1.1767.0 i40e 0000:3d:00.0: The driver for the device detected a
>>> newer version of the NVM image than expected. Please install the
>>> most recent version of the network driver.

Out of tree: https://sourceforge.net/projects/e1000/files/i40e%20stable/

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com


-----Original Message-----
From: Hisashi T Fujinaka [mailto:htodd at twofifty.com] 
Sent: Friday, June 7, 2019 1:50 PM
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: e1000-devel at lists.sourceforge.net; Netdev <netdev@vger.kernel.org>; intel-wired-lan <intel-wired-lan@lists.osuosl.org>; LKML <linux-kernel@vger.kernel.org>; Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: [E1000-devel] [Intel-wired-lan] i40e X722 RSS problem with NAT-Traversal IPsec packets

On Fri, 7 Jun 2019, Alexander Duyck wrote:

> On Fri, Jun 7, 2019 at 7:39 AM Lennart Sorensen 
> <lsorense@csclub.uwaterloo.ca> wrote:
>>
>> On Wed, May 22, 2019 at 10:39:56AM -0400, Lennart Sorensen wrote:
>>> OK I applied those two patches and get this:
>>>
>>> i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 
>>> 2.1.7-k
>>> i40e: Copyright (c) 2013 - 2014 Intel Corporation.
>>> i40e 0000:3d:00.0: fw 3.10.52896 api 1.6 nvm 4.00 0x80001577 
>>> 1.1767.0 i40e 0000:3d:00.0: The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.
>>> i40e 0000:3d:00.0: MAC address: a4:bf:01:4e:0c:87 i40e 0000:3d:00.0: 
>>> PFQF_HREGION[7]: 0x00000000 i40e 0000:3d:00.0: PFQF_HREGION[6]: 
>>> 0x00000000 i40e 0000:3d:00.0: PFQF_HREGION[5]: 0x00000000 i40e 
>>> 0000:3d:00.0: PFQF_HREGION[4]: 0x00000000 i40e 0000:3d:00.0: 
>>> PFQF_HREGION[3]: 0x00000000 i40e 0000:3d:00.0: PFQF_HREGION[2]: 
>>> 0x00000000 i40e 0000:3d:00.0: PFQF_HREGION[1]: 0x00000000 i40e 
>>> 0000:3d:00.0: PFQF_HREGION[0]: 0x00000000 i40e 0000:3d:00.0: 
>>> flow_type: 63 input_mask:0x0000000000004000 i40e 0000:3d:00.0: 
>>> flow_type: 46 input_mask:0x0007fff800000000 i40e 0000:3d:00.0: 
>>> flow_type: 45 input_mask:0x0007fff800000000 i40e 0000:3d:00.0: 
>>> flow_type: 44 input_mask:0x0007ffff80000000 i40e 0000:3d:00.0: 
>>> flow_type: 43 input_mask:0x0007fffe00000000 i40e 0000:3d:00.0: 
>>> flow_type: 42 input_mask:0x0007fffe00000000 i40e 0000:3d:00.0: 
>>> flow_type: 41 input_mask:0x0007fffe00000000 i40e 0000:3d:00.0: 
>>> flow_type: 40 input_mask:0x0007fffe00000000 i40e 0000:3d:00.0: 
>>> flow_type: 39 input_mask:0x0007fffe00000000 i40e 0000:3d:00.0: 
>>> flow_type: 36 input_mask:0x0006060000000000 i40e 0000:3d:00.0: 
>>> flow_type: 35 input_mask:0x0006060000000000 i40e 0000:3d:00.0: 
>>> flow_type: 34 input_mask:0x0006060780000000 i40e 0000:3d:00.0: 
>>> flow_type: 33 input_mask:0x0006060600000000 i40e 0000:3d:00.0: 
>>> flow_type: 32 input_mask:0x0006060600000000 i40e 0000:3d:00.0: 
>>> flow_type: 31 input_mask:0x0006060600000000 i40e 0000:3d:00.0: 
>>> flow_type: 30 input_mask:0x0006060600000000 i40e 0000:3d:00.0: 
>>> flow_type: 29 input_mask:0x0006060600000000 i40e 0000:3d:00.0: 
>>> flow_type: 27 input_mask:0x00000000002c0000 i40e 0000:3d:00.0: 
>>> flow_type: 26 input_mask:0x00000000002c0000 i40e 0000:3d:00.0: flow 
>>> type: 36 update input mask from:0x0006060000000000, 
>>> to:0x0001801800000000 i40e 0000:3d:00.0: flow type: 35 update input 
>>> mask from:0x0006060000000000, to:0x0001801800000000 i40e 
>>> 0000:3d:00.0: flow type: 34 update input mask 
>>> from:0x0006060780000000, to:0x0001801f80000000 i40e 0000:3d:00.0: 
>>> flow type: 33 update input mask from:0x0006060600000000, 
>>> to:0x0001801e00000000 i40e 0000:3d:00.0: flow type: 32 update input 
>>> mask from:0x0006060600000000, to:0x0001801e00000000 i40e 
>>> 0000:3d:00.0: flow type: 31 update input mask 
>>> from:0x0006060600000000, to:0x0001801e00000000 i40e 0000:3d:00.0: 
>>> flow type: 30 update input mask from:0x0006060600000000, 
>>> to:0x0001801e00000000 i40e 0000:3d:00.0: flow type: 29 update input 
>>> mask from:0x0006060600000000, to:0x0001801e00000000
>>>
>>> So seems the regions are all 0.
>>>
>>> All ipsec packets still hitting queue 0.
>>
>> So any news or more ideas to try or are we stuck hoping someone can 
>> fix the firmware?
>
> I had reached out to some folks over in the networking division hoping 
> that they can get a reproduction as I don't have the hardware that you 
> are seeing the issue on so I have no way to reproduce it.
>
> Maybe someone from that group can reply and tell us where they are on that?
>
> Thanks.
>
> - Alex

For some reason this isn't showing up in my work email. We had an internal conference this week and I think people are away. I'll see if I can chase some people down if they're still here and not on the way home.

--
Hisashi T Fujinaka - htodd at twofifty.com


_______________________________________________
E1000-devel mailing list
E1000-devel at lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/e1000-devel
To learn more about Intel&#174; Ethernet, visit http://communities.intel.com/community/wired
