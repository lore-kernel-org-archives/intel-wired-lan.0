From: Young, James M <james.m.young@intel.com>
Date: Thu, 2 Jul 2015 00:02:28 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07
	03/10]	i40e/i40evf: Update FW API with X722 support
In-Reply-To: <1433521234-33355-4-git-send-email-catherine.sullivan@intel.com>
References: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
 <1433521234-33355-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C227@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Friday, June 05, 2015 9:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Singhai, Anjali
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 03/10]
> i40e/i40evf: Update FW API with X722 support
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This patch does the firmware API update to support the new X722 device.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  48 ++++++
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 163
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  11 ++
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  49 ++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    | 163
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_prototype.h |  11 ++
>  6 files changed, 444 insertions(+), 1 deletion(-)
> 
Tested-By: Jim Young <james.m.young@intel.com>

