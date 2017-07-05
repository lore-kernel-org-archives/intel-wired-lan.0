From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Wed, 5 Jul 2017 21:15:56 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] i40e/i40evf: rename
 vf_offload_flags	to vf_cap_flags in struct virtchnl_vf_resource
In-Reply-To: <20170629131225.9251-2-sassmann@kpanic.de>
References: <20170629131225.9251-1-sassmann@kpanic.de>
 <20170629131225.9251-2-sassmann@kpanic.de>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B62650490D08@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Stefan Assmann
> Sent: Thursday, June 29, 2017 6:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH 1/2] i40e/i40evf: rename vf_offload_flags to
> vf_cap_flags in struct virtchnl_vf_resource
> 
> The current name of vf_offload_flags indicates that the bitmap is
> limited to offload related features. Make this more generic by renaming
> it to vf_cap_flags, which allows for other capabilities besides
> offloading to be added.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---

Hello Stefan,

Thanks for the patch series, but we believe the vf should be ignorant of its trusted status.  That being said, you've definitely pointed out a bug in our implementation so that if a vf ends up being configured as trusted, its unable to change its mac address itself when this is an allowed action for this configuration.  The pf can change the mac address for the vf, but the vf itself cannot, which is not correct.  We are working on an alternate solution that keeps the vf from knowing its trusted status, but its not a simple fix.

Thanks,

Carolyn

Carolyn Wyborny 
Linux Development 
Networking Division 
Intel Corporation 

  
