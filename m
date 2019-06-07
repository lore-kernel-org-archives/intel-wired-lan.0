From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 7 Jun 2019 12:32:51 -0700
Subject: [Intel-wired-lan] i40e X722 RSS problem with NAT-Traversal
 IPsec packets
In-Reply-To: <20190607143906.wgi344jcc77qvh24@csclub.uwaterloo.ca>
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
Message-ID: <CAKgT0Ue1M8_30PVPmoJy_EGo2mjM26ecz32Myx-hpnuq_6wdjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jun 7, 2019 at 7:39 AM Lennart Sorensen
<lsorense@csclub.uwaterloo.ca> wrote:
>
> On Wed, May 22, 2019 at 10:39:56AM -0400, Lennart Sorensen wrote:
> > OK I applied those two patches and get this:
> >
> > i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 2.1.7-k
> > i40e: Copyright (c) 2013 - 2014 Intel Corporation.
> > i40e 0000:3d:00.0: fw 3.10.52896 api 1.6 nvm 4.00 0x80001577 1.1767.0
> > i40e 0000:3d:00.0: The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.
> > i40e 0000:3d:00.0: MAC address: a4:bf:01:4e:0c:87
> > i40e 0000:3d:00.0: PFQF_HREGION[7]: 0x00000000
> > i40e 0000:3d:00.0: PFQF_HREGION[6]: 0x00000000
> > i40e 0000:3d:00.0: PFQF_HREGION[5]: 0x00000000
> > i40e 0000:3d:00.0: PFQF_HREGION[4]: 0x00000000
> > i40e 0000:3d:00.0: PFQF_HREGION[3]: 0x00000000
> > i40e 0000:3d:00.0: PFQF_HREGION[2]: 0x00000000
> > i40e 0000:3d:00.0: PFQF_HREGION[1]: 0x00000000
> > i40e 0000:3d:00.0: PFQF_HREGION[0]: 0x00000000
> > i40e 0000:3d:00.0: flow_type: 63 input_mask:0x0000000000004000
> > i40e 0000:3d:00.0: flow_type: 46 input_mask:0x0007fff800000000
> > i40e 0000:3d:00.0: flow_type: 45 input_mask:0x0007fff800000000
> > i40e 0000:3d:00.0: flow_type: 44 input_mask:0x0007ffff80000000
> > i40e 0000:3d:00.0: flow_type: 43 input_mask:0x0007fffe00000000
> > i40e 0000:3d:00.0: flow_type: 42 input_mask:0x0007fffe00000000
> > i40e 0000:3d:00.0: flow_type: 41 input_mask:0x0007fffe00000000
> > i40e 0000:3d:00.0: flow_type: 40 input_mask:0x0007fffe00000000
> > i40e 0000:3d:00.0: flow_type: 39 input_mask:0x0007fffe00000000
> > i40e 0000:3d:00.0: flow_type: 36 input_mask:0x0006060000000000
> > i40e 0000:3d:00.0: flow_type: 35 input_mask:0x0006060000000000
> > i40e 0000:3d:00.0: flow_type: 34 input_mask:0x0006060780000000
> > i40e 0000:3d:00.0: flow_type: 33 input_mask:0x0006060600000000
> > i40e 0000:3d:00.0: flow_type: 32 input_mask:0x0006060600000000
> > i40e 0000:3d:00.0: flow_type: 31 input_mask:0x0006060600000000
> > i40e 0000:3d:00.0: flow_type: 30 input_mask:0x0006060600000000
> > i40e 0000:3d:00.0: flow_type: 29 input_mask:0x0006060600000000
> > i40e 0000:3d:00.0: flow_type: 27 input_mask:0x00000000002c0000
> > i40e 0000:3d:00.0: flow_type: 26 input_mask:0x00000000002c0000
> > i40e 0000:3d:00.0: flow type: 36 update input mask from:0x0006060000000000, to:0x0001801800000000
> > i40e 0000:3d:00.0: flow type: 35 update input mask from:0x0006060000000000, to:0x0001801800000000
> > i40e 0000:3d:00.0: flow type: 34 update input mask from:0x0006060780000000, to:0x0001801f80000000
> > i40e 0000:3d:00.0: flow type: 33 update input mask from:0x0006060600000000, to:0x0001801e00000000
> > i40e 0000:3d:00.0: flow type: 32 update input mask from:0x0006060600000000, to:0x0001801e00000000
> > i40e 0000:3d:00.0: flow type: 31 update input mask from:0x0006060600000000, to:0x0001801e00000000
> > i40e 0000:3d:00.0: flow type: 30 update input mask from:0x0006060600000000, to:0x0001801e00000000
> > i40e 0000:3d:00.0: flow type: 29 update input mask from:0x0006060600000000, to:0x0001801e00000000
> >
> > So seems the regions are all 0.
> >
> > All ipsec packets still hitting queue 0.
>
> So any news or more ideas to try or are we stuck hoping someone can fix
> the firmware?

I had reached out to some folks over in the networking division hoping
that they can get a reproduction as I don't have the hardware that you
are seeing the issue on so I have no way to reproduce it.

Maybe someone from that group can reply and tell us where they are on that?

Thanks.

- Alex
