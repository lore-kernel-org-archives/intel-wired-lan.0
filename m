From: Young, James M <james.m.young@intel.com>
Date: Sat, 9 May 2015 00:06:14 +0000
Subject: [Intel-wired-lan] [net-next S4 09/15] i40e: Move the FD
	ATR/SB	messages to a higher debug level
In-Reply-To: <1429229172-143692-10-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
 <1429229172-143692-10-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9F9971@ORSMSX102.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next S4 09/15] i40e: Move the FD ATR/SB
> messages to a higher debug level
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> These are not useful unless SV is happening as there is a FD flush counter
> that tracks this.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: If2655b5a29687247d03a51d35f69854bbeb711ce
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++++++------
> drivers/net/ethernet/intel/i40e/i40e_txrx.c |  9 ++++++---
>  2 files changed, 18 insertions(+), 9 deletions(-)

Tested-by: Jim Young <james.m.young@intel.com>

