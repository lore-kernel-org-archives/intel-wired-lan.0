From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Oct 2018 08:25:16 -0700
Subject: [Intel-wired-lan] [Question] i40e: Enabling of promiscuous mode
 when MAC-VLAN Filter Table is Full
In-Reply-To: <F4CC6FACFEB3C54C9141D49AD221F7F93BF2D9F2@FRAEML521-MBX.china.huawei.com>
References: <F4CC6FACFEB3C54C9141D49AD221F7F93BF2D9F2@FRAEML521-MBX.china.huawei.com>
Message-ID: <CAKgT0UfoFKTB92-ef3VAFowzz7E9oJh7uvZNabXwLVhDvth+Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 10, 2018 at 4:59 AM Salil Mehta <salil.mehta@huawei.com> wrote:
>
> Hi Alex,
> I was going through the Intel i40e driver and I could see in the function i40e_aqc_add_filters()
> enabling promiscuous mode when the filter table is full.


Hi Salil,

I have added the intel-wired-lan list as I am no longer working on the
i40e driver or wired networking within Intel.

I have included the answers as best as I know them below.

> Below is excerpt from comment over the function:
>
> *
>  * Send a request to firmware via AdminQ to add a chunk of filters. Will set
>  * __I40E_VSI_OVERFLOW_PROMISC bit in vsi->state if the firmware has run out of
>  * space for more filters.
>  */
>
> Questions:
>
> 1. Could this be a security issue since all the packet would now be send to PF?

It shouldn't be because the PF can still filter based on unicast
address in the network stack.

> 2. In above case will the VLAN filtering still act on the packet? would the PF
>    also start receiving packets from unknown VLANs i.e. not configured in VLAN Table?

I think VLAN filtering is still active, but I could be wrong. I would
need somebody who is on the networking team to clarify.

> 3. If the VFs are *trusted* then would it still be appropriate to send traffic of one
>    VF belonging to same PF to other VF? I guess, the current scenario it can happen - right?

Are you running a VF in promiscuous mode while this is all going on?
I'm not quite sure how we jumped from MACVLAN to VFs.

>
> Thanks
> Salil

I hope this helps. I'm hoping somebody from networking team can
clarify on the points where I was not certain on things.

Thanks.

- Alex
