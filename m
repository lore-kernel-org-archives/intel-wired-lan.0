From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 19:29:18 +0000
Subject: [Intel-wired-lan] [next PATCH S16 14/15] i40e: increase AQ
	work	limit
In-Reply-To: <1443463964-148204-15-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
 <1443463964-148204-15-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2CF7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S16 14/15] i40e: increase AQ work
> limit
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> With 64 VFs, we can easily overwhelm the AQ on the PF if we have too low a
> limit on the number of AQ requests. This leads to ARQ overflow errors, and
> occasionally VFs that fail to initialize.
> 
> Since we really only hit this condition on initial VF driver load, the requests
> that we process are lightweight, so this extra work doesn't cause problems
> for the PF driver.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I620221520d8af987df6ace9ba938ffaf22107681
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
