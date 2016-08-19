From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Aug 2016 15:51:30 +0000
Subject: [Intel-wired-lan] [next PATCH S43 1/3] i40e: Correcting mutex
 usage	in client code
In-Reply-To: <1471475048-25835-1-git-send-email-bimmy.pujari@intel.com>
References: <1471475048-25835-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F9308@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, August 17, 2016 4:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S43 1/3] i40e: Correcting mutex usage
> in client code
> 
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> Correcting the mutex usage, in client_subtask(), mutex_unlock has to be
> called just before client_del_instance() since this function opens and later
> closes the same mutex again.
> Similarly in client_is_registered removing the mutex since it closes the mutex
> twice.
> 
> This is a patch suggested by RDMA team.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Change-ID: Icce519c266e4221b8a2a72a15ba5bf01750e5852
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
