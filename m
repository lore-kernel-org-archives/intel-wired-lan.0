From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 Feb 2019 00:13:20 +0000
Subject: [Intel-wired-lan] [PATCH S11 16/16] ice: fix overlong string,
 update stats output
In-Reply-To: <20190208205043.11975-17-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-17-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3662C6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 16/16] ice: fix overlong string, update
> stats output
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> A test started warning on a string truncation. This led to an unfortunate
> realization that we are likely not accounting for the stats length correctly
> before this patch, so fix the issue by putting "port." in front of all the PF stats,
> instead of magically prepending it at runtime.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 80 ++++++++++++++----------
> ----
>  1 file changed, 40 insertions(+), 40 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


