From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Fri, 7 Jul 2017 15:03:32 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] i40e/i40evf: rename
 vf_offload_flags to vf_cap_flags in struct virtchnl_vf_resource
In-Reply-To: <451f62e5-cacb-32a2-e7e4-a0d89f69d63d@kpanic.de>
References: <20170629131225.9251-1-sassmann@kpanic.de>
 <20170629131225.9251-2-sassmann@kpanic.de>
 <9BBC4E0CF881AA4299206E2E1412B62650490D08@ORSMSX102.amr.corp.intel.com>
 <CALgkqUpFST=oiS+yAFpkCiRS6JPqVg9R7_+3GMNvWoVnB_zoXg@mail.gmail.com>
 <9BBC4E0CF881AA4299206E2E1412B62650491AAE@ORSMSX102.amr.corp.intel.com>
 <451f62e5-cacb-32a2-e7e4-a0d89f69d63d@kpanic.de>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B62650492B50@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Stefan Assmann [mailto:sassmann at kpanic.de]
> Sent: Friday, July 07, 2017 1:04 AM
> To: Wyborny, Carolyn <carolyn.wyborny@intel.com>; Greg Rose
> <gvrose8192@gmail.com>
> Cc: intel-wired-lan at lists.osuosl.org; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; davem at davemloft.net
> Subject: Re: [Intel-wired-lan] [PATCH 1/2] i40e/i40evf: rename
> vf_offload_flags to vf_cap_flags in struct virtchnl_vf_resource
> 
[..]
> 
> Hi Carolyn,
> 
> the only other solution I can think of is to use the mailbox interface,
> which allows the PF to immediately allow or deny the MAC address change.
> If you can make that happen, it would indeed be a better solution.

Yes, a more thorough review of the code shows that we do check with the PF to allow or deny the change as part of the add filter function call.  However, today that does not happen if the PF has set the MAC address for the VF, trusted or not.  Ixgbe and i40e are different in this regard and there is some difference of opinion internally on the best approach, but we are actively working on it.
> 
> Independently of that decision, I'd still like to propose patch 1/2
> to be applied now. vf_offload_flags is used in struct virtchnl_vf_resource
> which is found in the generic header include/linux/avf/virtchnl.h.
> So we should keep it as generic as possible.
> 
> Let's make the change while the struct hasn't gained popularity
> outside of i40e/i40evf.

I'm fine with this change.

Thanks,

Carolyn


