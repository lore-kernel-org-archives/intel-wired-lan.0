From: Young, James M <james.m.young@intel.com>
Date: Wed, 1 Jul 2015 19:42:28 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 6/8]
	i40e:	provide correct API version to older VF drivers
In-Reply-To: <1433449442-31420-7-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
 <1433449442-31420-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1BFD5@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, June 04, 2015 1:24 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 6/8] i40e: provide
> correct API version to older VF drivers
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> This driver fully supports VF drivers using both the 1.0 and 1.1 versions of the
> virtual channel API. However, VF drivers using version 1.0 get upset if we
> provide them with a version other than that, and refuse to play with us.
> 
> Correct this by checking the VFs API version at the time that we store it off,
> and provide the correct version number back to the VF so we can all get
> along.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I86dfe02e67b2bef336b4b49a1bb072f3e7229abc
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
Tested-by: Jim Young <james.m.young@intel.com>

Actually not testable on net-next kernel as I cannot find a API 1.0 i40evf driver that will build on the 4.1.0rc7 kernel (kcompat issues)
This patch does not break current i40evf driver operation so I am letting it pass. 
