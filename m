From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 16 Dec 2016 21:54:38 +0000
Subject: [Intel-wired-lan] [next PATCH S57 03/11] i40e: remove
 unnecessary	call to i40e_update_link_info
In-Reply-To: <1481586257-28872-4-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
 <1481586257-28872-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA49991@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, December 12, 2016 3:44 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S57 03/11] i40e: remove unnecessary
> call to i40e_update_link_info
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This call is made just prior to running i40e_link_event. In i40e_link_event, we
> set hw->phy.get_link_info to true just prior to calling i40e_get_link_status,
> which conveniently runs i40e_update_link_info for us. Thus, we are running
> i40e_update_link_info twice, which seems like something we don't need to
> do...
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I36467a570f44b7546d218c99e134ff97c2709315
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


