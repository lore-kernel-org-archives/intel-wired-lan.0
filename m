From: Young, James M <james.m.young@intel.com>
Date: Thu, 2 Jul 2015 00:04:40 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 08/10]
 i40e:	Add IWARP support for X722
In-Reply-To: <1433521234-33355-9-git-send-email-catherine.sullivan@intel.com>
References: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
 <1433521234-33355-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C241@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Friday, June 05, 2015 9:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Singhai, Anjali
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 08/10] i40e:
> Add IWARP support for X722
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> X722 supports IWARP, this patch handles checking for PE critical errors.
> Since the driver doesn't support the IWARP interface for now, this patch just
> does bare minimum to log a message oif a PE critical error happens.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
Tested-By: Jim Young <james.m.young@intel.com>
Driver does not currently support IWARP but this patch doesn't break anything with the standard i40e and i40evf functionality. 

