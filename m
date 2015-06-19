From: Young, James M <james.m.young@intel.com>
Date: Fri, 19 Jun 2015 20:43:07 +0000
Subject: [Intel-wired-lan] [net-next S5 03/15] i40e: ignore duplicate
 port	VLAN requests
In-Reply-To: <1430161042-28494-4-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
 <1430161042-28494-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1A102@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, April 27, 2015 11:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next S5 03/15] i40e: ignore duplicate port
> VLAN requests
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If user attempts to set a port VLAN on a VF that already has the same port
> VLAN configured, the driver will go through a completely unnecessary flurry
> of filter removals and filter adds. Just check for this condition and return
> success instead of doing a bunch of busywork.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ia1a9e83e6ed48b3f4658bc20dfc6af0cf525d54a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Tested-by: Jim Young <james.m.young@intel.com>
