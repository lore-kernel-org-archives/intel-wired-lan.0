From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Oct 2016 19:30:06 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 06/15] i40e:
	implement	__i40e_del_filter and use where applicable
In-Reply-To: <1475685046-16900-7-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FC92@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S49-V2 06/15] i40e: implement
> __i40e_del_filter and use where applicable
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When inside a loop where we call i40e_del_filter we use an O(n^2) pattern
> where i40e_del_filter calls i40e_find_filter for us. We can avoid this O(n^2)
> logic by factoring a function, __i40e_del_filter() out from the i40e_del_filter
> code. This allows us to re-use the delete logic where appropriate without
> having to search for the filter twice.
> 
> This new function benefits several functions including i40e_vsi_add_vlan,
> i40e_vsi_kill_vlan, i40e_del_mac_vlan_all, and i40e_vsi_release.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I75fabe0f53bf73f56b80d342e5fdcfcc28f4d3eb
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 92 ++++++++++++++++++----
> -------
>  1 file changed, 59 insertions(+), 33 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


