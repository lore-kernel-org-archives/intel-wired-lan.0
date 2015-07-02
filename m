From: Young, James M <james.m.young@intel.com>
Date: Thu, 2 Jul 2015 20:58:49 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07
	07/10]	i40e/i40evf: Add TX/RX outer UDP checksum support for X722
In-Reply-To: <1433521234-33355-8-git-send-email-catherine.sullivan@intel.com>
References: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
 <1433521234-33355-8-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C4CA@ORSMSX102.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 07/10]
> i40e/i40evf: Add TX/RX outer UDP checksum support for X722
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> X722 supports offloading of outer UDP TX and RX checksum for tunneled
> packets. This patch exposes the support and leaves it enabled by default.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 16 +++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 10 ++++++++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 13 +++++++++++++
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  2 ++
> drivers/net/ethernet/intel/i40evf/i40e_type.h | 10 ++++++++--
>  7 files changed, 50 insertions(+), 5 deletions(-)
> 
Tested-By: Jim Young <james.m.young@intel.com>

