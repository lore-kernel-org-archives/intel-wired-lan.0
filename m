From: Young, James M <james.m.young@intel.com>
Date: Tue, 21 Jul 2015 19:13:37 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07
	09/10]	i40e/i40evf: Add ATR HW eviction support for X722
In-Reply-To: <1433521234-33355-10-git-send-email-catherine.sullivan@intel.com>
References: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
 <1433521234-33355-10-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA21099@ORSMSX102.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 09/10]
> i40e/i40evf: Add ATR HW eviction support for X722
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> X722 supports evicting ATR filters in the HW. With this patch, we enable the
> feature in the driver and avoid filter deletion by the driver.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 ++++++++++
> drivers/net/ethernet/intel/i40e/i40e_type.h |  4 ++++
>  2 files changed, 14 insertions(+)
> 

Tested-by: Jim Young <james.m.young@intel.com>

Retested after a HW change, feature works now. 

