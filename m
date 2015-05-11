From: Young, James M <james.m.young@intel.com>
Date: Mon, 11 May 2015 16:45:49 +0000
Subject: [Intel-wired-lan] [Fwd: [net-next S4 14/15] i40e/i40evf: remove
 time_stamp member]
In-Reply-To: <1431148081.32618.35.camel@jtkirshe-mobl>
References: <1431148081.32618.35.camel@jtkirshe-mobl>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9F9BE4@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Kirsher, Jeffrey T
> Sent: Friday, May 08, 2015 10:08 PM
> To: Young, James M
> Subject: [Fwd: [Intel-wired-lan] [net-next S4 14/15] i40e/i40evf: remove
> time_stamp member]
> 
> -------- Forwarded Message --------
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next S4 14/15] i40e/i40evf: remove
> time_stamp member
> Date: Thu, 16 Apr 2015 20:06:11 -0400
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver doesn't use the time_stamp member to determine if there is a
> tx_hang any more. There really isn't any point to the variable at all so just
> remove it. It was left over from a previous tx_hang design.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I4c814827e1bcb46e45118fe37acdcfa814fb62a0
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 10 ----------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 -
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  7 -------
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  1 -
>  4 files changed, 19 deletions(-)

Tested-by: Jim Young <james.m.young@intel.com>

