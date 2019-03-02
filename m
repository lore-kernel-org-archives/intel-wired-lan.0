From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 2 Mar 2019 00:22:59 +0000
Subject: [Intel-wired-lan] [next PATCH S3 3/9] i40e: remove error msg
 when vf with port vlan tries to remove vlan 0
In-Reply-To: <20190228175255.54754-3-alice.michael@intel.com>
References: <20190228175255.54754-1-alice.michael@intel.com>
 <20190228175255.54754-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3676E1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, February 28, 2019 9:53 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S3 3/9] i40e: remove error msg when
> vf with port vlan tries to remove vlan 0
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> VF's attempt to delete vlan 0 when a port vlan is configured is harmless in this
> case pf driver just does nothing.  If vf will try to remove other vlans when a
> port vlan is configured it will still produce error as before.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


