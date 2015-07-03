From: Young, James M <james.m.young@intel.com>
Date: Fri, 3 Jul 2015 22:34:36 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 10/10]
 i40e:	Add AQ commands for NVM Update for X722
In-Reply-To: <1433521234-33355-11-git-send-email-catherine.sullivan@intel.com>
References: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
 <1433521234-33355-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C6EF@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Friday, June 5, 2015 9:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 10/10] i40e:
> Add AQ commands for NVM Update for X722
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> X722 does NVM update via the adminq queue, so we need to add support
> for that.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 129
> +++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
> 
NVM update via lanconf (in qv driverless mode) after this patch did not succeed. As a caveat; The NVM update was done on a FPGA not on actual X722 hardware. This patch does not otherwise detract from the other driver functions. 

