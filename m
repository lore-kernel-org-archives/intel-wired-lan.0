From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Oct 2016 16:42:14 +0000
Subject: [Intel-wired-lan] [next PATCH S50 6/6] i40e: removed
 unreachable	code
In-Reply-To: <1476224818-16844-7-git-send-email-bimmy.pujari@intel.com>
References: <1476224818-16844-1-git-send-email-bimmy.pujari@intel.com>
 <1476224818-16844-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA11421@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 11, 2016 3:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sadowski, Filip <filip.sadowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S50 6/6] i40e: removed unreachable
> code
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> Removed some of unnecessary if statements and unreachable code found
> by static code analysis tool.
> The return value of i40e_vsi_control_rings(..., false) is always 0. So, test for
> non-zero will never be true. The function has been split into "int
> i40e_vsi_start_rings()" and "void i40e_vsi_stop_rings()" for better
> understanding.
> Similarly, the function i40e_vsi_kill_vlan() never fails. So, checking for return
> value is also unnecessary. Function definition changed to void.
> The i40e_loopback_test() function is not impelemented. The function and all
> references to loopback testing were removed.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> Change-ID: Id45cf66f6689ce2bc4e887de13f073e30e8431bd
> ---
> Testing hints:
>         Found by static code analysis. Test by code inspection.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h             |  5 +--
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 18 ----------
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 41 ++++++++++++---------
> -
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 29 +++++----------
>  4 files changed, 33 insertions(+), 60 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

