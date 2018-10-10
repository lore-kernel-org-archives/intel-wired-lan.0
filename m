From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Wed, 10 Oct 2018 22:42:18 +0000
Subject: [Intel-wired-lan] [Question] i40e: Enabling of promiscuous mode
 when MAC-VLAN Filter Table is Full
In-Reply-To: <CAKgT0UfoFKTB92-ef3VAFowzz7E9oJh7uvZNabXwLVhDvth+Wg@mail.gmail.com>
References: <F4CC6FACFEB3C54C9141D49AD221F7F93BF2D9F2@FRAEML521-MBX.china.huawei.com>
 <CAKgT0UfoFKTB92-ef3VAFowzz7E9oJh7uvZNabXwLVhDvth+Wg@mail.gmail.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6267C64CBC7@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Alexander Duyck
> Sent: Wednesday, October 10, 2018 8:25 AM
> To: salil.mehta at huawei.com; intel-wired-lan at osuosl.org
> Subject: Re: [Intel-wired-lan] [Question] i40e: Enabling of promiscuous mode
> when MAC-VLAN Filter Table is Full
> 
[..]
> I think VLAN filtering is still active, but I could be wrong. I would
> need somebody who is on the networking team to clarify.

[CMW] The VLAN filtering would be off because of the promiscuous setting.  There would be no filtering in this case.

> > 3. If the VFs are *trusted* then would it still be appropriate to send traffic
> of one
> >    VF belonging to same PF to other VF? I guess, the current scenario it can
> happen - right?
> 
> Are you running a VF in promiscuous mode while this is all going on?
> I'm not quite sure how we jumped from MACVLAN to VFs.

[CMW]  The standard untrusted VF's should not see each other's traffic in this scenario where only the PF is in promiscuous because of the filter overflow.  

Thanks,

Carolyn

Carolyn Wyborny 
Linux Development 
Networking Division 
Intel Corporation 


> 
> >
> > Thanks
> > Salil
> 
> I hope this helps. I'm hoping somebody from networking team can
> clarify on the points where I was not certain on things.
> 
> Thanks.
> 
> - Alex
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
