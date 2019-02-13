From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Feb 2019 20:16:38 +0000
Subject: [Intel-wired-lan] [next PATCH S2-V2 07/12] i40e: Remove
 misleading messages for untrusted VF
In-Reply-To: <20190206230826.24970-7-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
 <20190206230826.24970-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D365FCF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, February 6, 2019 3:08 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Siwik, Grzegorz <grzegorz.siwik@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S2-V2 07/12] i40e: Remove misleading
> messages for untrusted VF
> 
> From: Grzegorz Siwik <grzegorz.siwik@intel.com>
> 
> Removed misleading messages when untrusted VF tries to add more
> addresses than NIC limit
> 
> Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


