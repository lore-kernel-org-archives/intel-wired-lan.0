From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 24 Aug 2016 22:27:39 +0000
Subject: [Intel-wired-lan] [next PATCH S44 4/6] i40e: return correct
 opcode	to VF
In-Reply-To: <1472063631-9033-5-git-send-email-bimmy.pujari@intel.com>
References: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
 <1472063631-9033-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FAAB3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, August 24, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S44 4/6] i40e: return correct opcode
> to VF
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> This conditional is backward, so the driver responds back to the VF with the
> wrong opcode. Do the old switcheroo to fix this.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I384035b0fef8a3881c176de4b4672009b3400b25
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


