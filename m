From: Young, James M <james.m.young@intel.com>
Date: Tue, 5 May 2015 17:44:03 +0000
Subject: [Intel-wired-lan] [net-next S4 01/15] i40e: Collect PFC XOFF
	RX	stats even in single TC case
In-Reply-To: <1429229172-143692-2-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
 <1429229172-143692-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9F8FCA@ORSMSX102.amr.corp.intel.com>
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
> Cc: Parikh, Neerav
> Subject: [Intel-wired-lan] [net-next S4 01/15] i40e: Collect PFC XOFF RX stats
> even in single TC case
> 
> From: Neerav Parikh <neerav.parikh@intel.com>
> 
> When PFC is enabled for any UP in single TC configuration the driver didn't
> collect the PFC XOFF RX stats. Though a single TC with PFC enabled is not a
> common scenario do not prevent the driver from collecting stats if firmware
> indicates that PFC is enabled.
> 
> Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
> Change-ID: Ie20bd58b07608b528f3c6d95894c9ae56b00077a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Tested-by: Jim Young <james.m.young@intel.com>
	No DCB features tested by my, base driver only, this patch does not affect base driver function.
