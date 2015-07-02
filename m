From: Young, James M <james.m.young@intel.com>
Date: Thu, 2 Jul 2015 17:28:03 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07
	06/10]	i40e/i40evf: Add support for writeback on ITR feature
	for X722
In-Reply-To: <1433521234-33355-7-git-send-email-catherine.sullivan@intel.com>
References: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
 <1433521234-33355-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C3A5@ORSMSX102.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 06/10]
> i40e/i40evf: Add support for writeback on ITR feature for X722
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> X722 fixes an issue from X710 where TX descriptor WB would not hapen if the
> interrupts were disabled. In order for the write backs to happen a bit needs
> to be set in the dynamic interrupt control register called WB_ON_ITR. With
> this feature, the SW driver need not arm SW interrupts to work around the
> issue in X710.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 46
> +++++++++++++++++++++------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  2 ++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 38 ++++++++++++++++------
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  2 ++
>  drivers/net/ethernet/intel/i40evf/i40evf.h    |  1 +
>  7 files changed, 74 insertions(+), 18 deletions(-)
> 

Tested-by: Jim Young <james.m.young@intel.com>

