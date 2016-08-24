From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 24 Aug 2016 22:28:57 +0000
Subject: [Intel-wired-lan] [next PATCH S44 5/6] i40e: Fix to check for
 NULL
In-Reply-To: <1472063631-9033-6-git-send-email-bimmy.pujari@intel.com>
References: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
 <1472063631-9033-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FAAC2@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S44 5/6] i40e: Fix to check for NULL
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes an issue in the virt channel code, where a return from
> i40e_find_vsi_from_id was not checked for NULL when applicable.
> Without this patch, there is a risk for panic and static analysis tools complain.
> This patch fixes the problem by adding the check and adding an additional
> input check for similar reasons.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: I7e9be88eb7a3addb50eadc451c8336d9e06f5394
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


