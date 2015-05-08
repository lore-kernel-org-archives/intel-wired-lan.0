From: Young, James M <james.m.young@intel.com>
Date: Fri, 8 May 2015 17:56:04 +0000
Subject: [Intel-wired-lan] [net-next S4 04/15] i40e/i40evf: Add stats
	to	count Tunnel ATR hits
In-Reply-To: <1429229172-143692-5-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
 <1429229172-143692-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9F97CC@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, April 16, 2015 5:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Singhai, Anjali
> Subject: [Intel-wired-lan] [net-next S4 04/15] i40e/i40evf: Add stats to count
> Tunnel ATR hits
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> Add a 3rd dynamic filter counter to track Tunneled ATR hits separately.
> Ethtool port stat "fdir_atr_tunnel_match"
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: Idd978b6db2a462b5722397cd2ffd04ef055f8655
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  3 +++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  4 ++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 13 ++++++++++---
>  drivers/net/ethernet/intel/i40e/i40e_type.h    |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h  |  1 +
>  6 files changed, 20 insertions(+), 3 deletions(-)
 
Tested-by: Jim Young <james.m.young@intel.com>

