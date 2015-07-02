From: Young, James M <james.m.young@intel.com>
Date: Thu, 2 Jul 2015 23:03:38 +0000
Subject: [Intel-wired-lan] [net-next S4 v2 10/15] i40e/i40evf: Add stats
 to	track FD ATR and SB dynamic enable state
In-Reply-To: <1429745646-183026-1-git-send-email-catherine.sullivan@intel.com>
References: <1429745646-183026-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C563@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, April 22, 2015 4:34 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Singhai, Anjali
> Subject: [Intel-wired-lan] [net-next S4 v2 10/15] i40e/i40evf: Add stats to
> track FD ATR and SB dynamic enable state
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> Since the driver can dynamically enable/disable FD ATR and SB features,
> these stats help keep track of the current state and along with fd_flush count
> provide a means to debug what could be going on with the flow director
> filters. This will take away the need for being verbose in our debug logs with
> respect to FD.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I29224f750fe6602391043655d18996570720377d
> ---
> v2: Change the binary and's in if statements to logical and's
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 12 ++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h    |  2 ++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h  |  2 ++
>  4 files changed, 18 insertions(+)
> 
Tested-By: Jim Young <james.m.young@intel.com>
Status indicators are there in ethtool -S

