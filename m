From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 Jan 2018 22:42:11 +0000
Subject: [Intel-wired-lan] [PATCH] i40evf: Use the correct iterator to
 access the vlan filter
In-Reply-To: <1516801158-60944-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1516801158-60944-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94189C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of harshitha.ramamurthy at intel.com
> Sent: Wednesday, January 24, 2018 5:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40evf: Use the correct iterator to access
> the vlan filter
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> A previous commit changed the name of the iterator to the vlan_filter_list.
> Use the correct iterator to access the vlan filter.
> 
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


