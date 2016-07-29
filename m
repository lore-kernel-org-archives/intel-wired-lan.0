From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 29 Jul 2016 17:04:35 +0000
Subject: [Intel-wired-lan] [next PATCH S40-V2 07/12] i40e: Force
 register	writes to mitigate sync issues with iwarp VF driver
In-Reply-To: <1469646161-30024-8-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
 <1469646161-30024-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EB943@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, July 27, 2016 12:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S40-V2 07/12] i40e: Force register
> writes to mitigate sync issues with iwarp VF driver
> 
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> This patch is a fix for the bug i.e. unable to create iwarp device in VF. This is a
> sync issue and the iwarp device open is called even before the PCI register
> writes are done.
> 
> Forcing the PCI register writes to happen just before it exits the function.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Change-ID: I60c6a2c709da89e845f2764cc50ce8b7373c8c44
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No reset messages during VF creation
