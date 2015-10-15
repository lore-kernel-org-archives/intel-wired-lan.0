From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 15 Oct 2015 19:55:28 +0000
Subject: [Intel-wired-lan] [net PATCH] i40e: fix annoying message
In-Reply-To: <1443833841-2862-1-git-send-email-jesse.brandeburg@intel.com>
References: <1443833841-2862-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D1E68@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Friday, October 02, 2015 5:57 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net PATCH] i40e: fix annoying message
> 
> The driver was printing a message about not being able to assign VMDq
> because of a lack of MSI-X vectors.
> 
> This was because a line was missing that initialized a variable, simply a merge
> error.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes not applied, MSI-X vector error message does not appear on driver load
