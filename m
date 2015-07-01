From: Young, James M <james.m.young@intel.com>
Date: Wed, 1 Jul 2015 20:32:10 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 5/8]
	i40evf:	support virtual channel API version 1.1
In-Reply-To: <1433449442-31420-6-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
 <1433449442-31420-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C04C@ORSMSX102.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 5/8] i40evf:
> support virtual channel API version 1.1
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Store off the PF's API version, then use it to determine whether or not to
> send it our capabilities. Change the version checking to allow for PF drivers
> with lower API versions than our current version, so we can still talk to PF
> drivers over the 1.0 API.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I8edc55d1229c7decf0ed3f285a63032694007c2e
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c     | 6 ++++++
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 7 +++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
Tested-By: Jim young <james.m.young@intel.com>
Actually not testable on net-next kernel as I cannot find a API 1.0 i40e driver that will build on the 4.1.0rc7 kernel (kcompat issues) This patch does not break current i40e driver operation so I am letting it pass. 
_______________________________________________


