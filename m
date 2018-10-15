From: Salil Mehta <salil.mehta@huawei.com>
Date: Mon, 15 Oct 2018 10:12:06 +0000
Subject: [Intel-wired-lan] [Question] i40e: Enabling of promiscuous mode
 when MAC-VLAN Filter Table is Full
In-Reply-To: <CAKgT0UfoFKTB92-ef3VAFowzz7E9oJh7uvZNabXwLVhDvth+Wg@mail.gmail.com>
References: <F4CC6FACFEB3C54C9141D49AD221F7F93BF2D9F2@FRAEML521-MBX.china.huawei.com>
 <CAKgT0UfoFKTB92-ef3VAFowzz7E9oJh7uvZNabXwLVhDvth+Wg@mail.gmail.com>
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BF391AB@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Alex and Carolyn,
Thanks so much for replying and extending your help in this regard.

I am pasting Carolyn's reply from other mail to this one for
the sake of continuity.

> From: Wyborny, Carolyn [mailto:carolyn.wyborny at intel.com]
> Sent: Wednesday, October 10, 2018 11:42 PM
>
> > From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> > Sent: Wednesday, October 10, 2018 4:25 PM
> > 
> > On Wed, Oct 10, 2018 at 4:59 AM Salil Mehta <salil.mehta@huawei.com>
> > wrote:
> > >
> > > Hi Alex,
> > > I was going through the Intel i40e driver and I could see in the
> > > function i40e_aqc_add_filters()
> > > enabling promiscuous mode when the filter table is full.
> > 
> > 
> > Hi Salil,
> > 
> > I have added the intel-wired-lan list as I am no longer working on the
> > i40e driver or wired networking within Intel.

sure, got it.

> > 
> > I have included the answers as best as I know them below.
> > 
> > > Below is excerpt from comment over the function:
> > >
> > > *
> > >  * Send a request to firmware via AdminQ to add a chunk of filters. Will set
> > >  * __I40E_VSI_OVERFLOW_PROMISC bit in vsi->state if the firmware has run out of
> > >  * space for more filters.
> > >  */
> > >
> > > Questions:
> > >
> > > 1. Could this be a security issue since all the packet would now be
> > send to PF?
> > 
> > It shouldn't be because the PF can still filter based on unicast
> > address in the network stack.

ok sure, I understand. But maybe we might end up doing bit of tradeoff
(security vs performance)as in this case filtering will eat up precious
CPU resources?


> > > 2. In above case will the VLAN filtering still act on the packet? would the PF
> > >    also start receiving packets from unknown VLANs i.e. not configured in VLAN Table?
> > 
> > I think VLAN filtering is still active, but I could be wrong. I would
> > need somebody who is on the networking team to clarify.
>
> [CMW] The VLAN filtering would be off because of the promiscuous setting.
> There would be no filtering in this case.

ok. does this means if suppose VFs are configured by user to use promisc mode they will start to
receive each other's traffic as well? 

Example where I might need promisc mode traffic in VMs, suppose I have some bridging requirement
inside the VMs, maybe say for nested virtualization or OVS-DPDK running inside VM or Dockers?


> > 
> > > 3. If the VFs are *trusted* then would it still be appropriate to send traffic of one
> > >    VF belonging to same PF to other VF? I guess, the current scenario it can happen - right?
> > 
> > Are you running a VF in promiscuous mode while this is all going on?
> > I'm not quite sure how we jumped from MACVLAN to VFs.
> 
> [CMW]  The standard untrusted VF's should not see each other's traffic
> in this scenario where only the PF is in promiscuous because of the
> filter overflow.

Yes, I was contemplating the scenario where user could enable promiscuous mode even for the VFs.
In such a case, VF should only receive traffic after VLAN filtering so that we could bar the
visibility of traffic related to one VF from the other VFs.


But if we end up in a situation where promisc mode is implicitly enabled(as table full condition
was encountered) while adding entry to MAC-VLAN and VLAN filtering is suppose disabled
we might end up in a scenario where one VF might be able to see others traffic as well?


> > I hope this helps. I'm hoping somebody from networking team can
> > clarify on the points where I was not certain on things.

Thank you so much again for replying.

Best regards
Salil.

