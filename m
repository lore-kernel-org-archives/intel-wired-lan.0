From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Oct 2016 16:27:02 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 11/15] i40e: remove
 duplicate	add/delete adminq command code for filters
In-Reply-To: <1475685046-16900-12-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-12-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FBDC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S49-V2 11/15] i40e: remove duplicate
> add/delete adminq command code for filters
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We duplicate some code around adding and deleting filters using the adminq
> interface. This is prone to errors in case there are bugs. Use functions which
> extract the logic to their own portion so that we don't duplicate it twice in
> code.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I60d68aeb887976787dec00b23ab386a106e61465
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 156 +++++++++++++++-------
> ------
>  1 file changed, 84 insertions(+), 72 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


