From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 9 Nov 2017 22:38:12 +0000
Subject: [Intel-wired-lan] [net] i40e: fix the calculation of VFs mac
 addresses
In-Reply-To: <20171107200607.62104-1-jeffrey.t.kirsher@intel.com>
References: <20171107200607.62104-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAE685@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Kirsher, Jeffrey T
> Sent: Tuesday, November 7, 2017 12:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zijie Pan <zijie.pan@6wind.com>; Singhai, Anjali
> <anjali.singhai@intel.com>; Bowers, AndrewX
> <andrewx.bowers@intel.com>; Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Subject: [net] i40e: fix the calculation of VFs mac addresses
> 
> From: Zijie Pan <zijie.pan@6wind.com>
> 
> num_mac should be increased only after the call to i40e_add_mac_filter().
> 
> Fixes: 5f527ba962e2 ("i40e: Limit the number of MAC and VLAN addresses
> that can be added for VFs")
> CC: Anjali Singhai Jain <anjali.singhai@intel.com>
> CC: Andrew Bowers <andrewx.bowers@intel.com>
> Signed-off-by: Zijie Pan <zijie.pan@6wind.com>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Reviewed-by: Tushar Dave <tushar.n.dave@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 21 +++++++++++--------
> --
>  1 file changed, 11 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


