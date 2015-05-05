From: Young, James M <james.m.young@intel.com>
Date: Tue, 5 May 2015 17:53:07 +0000
Subject: [Intel-wired-lan] [net-next S4 02/15] i40e: Disable
	offline	diagnostics if VFs are enabled
In-Reply-To: <1429229172-143692-3-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
 <1429229172-143692-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9F9020@ORSMSX102.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next S4 02/15] i40e: Disable offline diagnostics
> if VFs are enabled
> 
> From: Greg Rose <gregory.v.rose@intel.com>
> 
> Require the user to disable virtual functions before running the device offline
> diagnostics.  The offline diagnostics are intended to ensure basic operation of
> the device - it is beyond the scope of the diagnostic test to handle the
> additional complexity of bringing all the virtual functions offline and then
> back online for each test run.
> 
> Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> Change-ID: Ic0b854851a09fc85df0c9e82c220e45885457c30
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 27
> ++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  7 ++++++
>  2 files changed, 34 insertions(+)

Tested-by: Jim Young <james.m.young@intel.com>
	
