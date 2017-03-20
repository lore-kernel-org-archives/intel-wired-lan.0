From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 23:05:16 +0000
Subject: [Intel-wired-lan] [next PATCH S62 6/6] i40e:
	remove	FDIR_REQUIRES_REINIT driver flag
In-Reply-To: <1489177325-13156-7-git-send-email-bimmy.pujari@intel.com>
References: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
 <1489177325-13156-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A104066E3@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, March 10, 2017 12:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S62 6/6] i40e: remove
> FDIR_REQUIRES_REINIT driver flag
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This flag hasn't been used since commit 1e1be8f622ee ("i40e: ATR policy
> change to flush the table to clean stale ATR rules").
> 
> Lets simplify things and just remove it.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I76279d84db8a2fd96f445b96aa413059f9256879
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


