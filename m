From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 1 Aug 2016 14:10:40 +0000
Subject: [Intel-wired-lan] [next PATCH S40-V2 08/12] i40e: Don't
	notify	client of VF reset during VF creation
In-Reply-To: <1469646161-30024-9-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
 <1469646161-30024-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F1F74@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, July 27, 2016 12:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S40-V2 08/12] i40e: Don't notify client
> of VF reset during VF creation
> 
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> VF goes through reset path during VF creation which happens to also have
> notification of VF reset to client. Adding conditional check to avoid wrongly
> notifying VF reset during VF creation.
> 
> Also changing the call order of VF enable, calling it after VF creation rather
> than before.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Change-ID: I96eabd99deae746a2f0fc465194c886f196178ce
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No reset messages during VF creation
