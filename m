From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Sep 2016 17:26:50 +0000
Subject: [Intel-wired-lan] [next PATCH S45 06/10] i40e: add encap csum
 VF	offload flag
In-Reply-To: <1473210312-29592-7-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
 <1473210312-29592-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FC85C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, September 06, 2016 6:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S45 06/10] i40e: add encap csum VF
> offload flag
> 
> From: Preethi Banala <preethi.banala@intel.com>
> 
> Add ENCAP_CSUM offload negotiation flag. Currently VF assumes checksum
> offload for encapsulated packets is supported by default. Going forward, this
> feature needs to be negotiated with PF before advertising to the stack.
> Hence, we need a flag to control it.
> This is in regards to prepping up for VF base mode functionality support.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> Change-ID: Iaab1f25cc0abda5f2fbe3309092640f0e77d163e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 1 +
>  2 files changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


