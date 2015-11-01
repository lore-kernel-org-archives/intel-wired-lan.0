From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Sun, 1 Nov 2015 21:03:52 +0000
Subject: [Intel-wired-lan] [PATCH v3 net] i40e: Look up MAC address in
 Open Firmware or IDPROM
In-Reply-To: <20151101162407.GA26373@oracle.com>
References: <20151030150344.GG9312@oracle.com>
 <FC41C24E35F18A40888AACA1A36F3E418AFACA14@fmsmsx115.amr.corp.intel.com>
 <20151030183645.GD32759@oracle.com>
 <FC41C24E35F18A40888AACA1A36F3E418AFACA8F@fmsmsx115.amr.corp.intel.com>
 <20151030192437.GE32759@oracle.com>
 <FC41C24E35F18A40888AACA1A36F3E418AFACC2E@fmsmsx115.amr.corp.intel.com>
 <20151030231301.GA14974@oracle.com> <20151101162407.GA26373@oracle.com>
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AFAD1C9@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Sowmini Varadhan [mailto:sowmini.varadhan at oracle.com]
> Sent: Sunday, November 01, 2015 8:24 AM
> 

[...]

> So I figured out why it all "seemed to work" - my test env had another
> obscure init process that was marking the link promiscuous.  I guess
> that was having the side-effect of somehow setting the filters above.
> 
> But looks like there's more to getting this right than just calling
> i40e_aq_mac_address_write() - I think it also needs a
> i40e_aq_add_macvlan().
> 
> I was able to get this to work by calling a the core part of
> i40e_set_mac just before register_netdev. In my patch (RFC patch
> in a separate thread - please review) I now have this sequence in
> i40e_probe
> 
> 	err = i40e_get_platform_mac_addr(pdev, hw->mac.addr);
> 	if (err)
> 		i40e_get_mac_addr(hw, hw->mac.addr);
> 	 :
> 	i40e_setup_pf_switch(..);
> 
> And the resulting i40e_vsi_setup() from i40e_setup_pf_switch()
> will end up doing the right thing by invoking the guts of
> i40e_set_mac(), which is basically the  sequence:
> 	i40e_aq_mac_address_write()
> 	i40e_aq_add_macvlan()
> 
> I dont know if it is necessary/possible/important to set up the
> filters sooner in the sequence- the add_macvlan needs an "seid",
> and I could not tell when (in the ":" code above) the right seid
> can be found.
> 
> Please review the RFC patch I'll be sending shortly.
> 
> --Sowmini

Yeah, because of the underlying HW we need to manage, and the fact that we can't ask it for the filters it knows, it becomes a bit convoluted.  To manage and replay the filter lists, we use the i40e_{add,del}_filter() routines on the individual VSI filter lists.  I'm thinking you're on the right track, but we may not want to bypass the VSI's filter list.

My brain's not in gear this weekend so I'll review the patch later.  In the meantime, be sure to test what happens over a reset, such as what happens when the MTU is changed.  This will make sure that the replay of mac and vlan filters happens correctly.  You'll want to test this with and without vlans.

sln

