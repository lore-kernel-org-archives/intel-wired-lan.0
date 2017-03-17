From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 Mar 2017 19:11:28 +0000
Subject: [Intel-wired-lan] [PART1 PATCH 11/11] i40e: always remove
	old	filter when adding new FDir filter
In-Reply-To: <20170206223913.31525-2-jacob.e.keller@intel.com>
References: <20170206223913.31525-1-jacob.e.keller@intel.com>
 <20170206223913.31525-2-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A104030B3@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, February 6, 2017 2:39 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PART1 PATCH 11/11] i40e: always remove old filter
> when adding new FDir filter
> 
> The previous code relied on i40e_match_fdir_input_set to determine when
> determining whether to free the old filter. Change this code so that we
> simply unconditionally delete the old filter, even if it's identical to the new
> filter. This ensures that we don't leak any memory, and that we always
> update the filters as expected.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 32 ++++++--------------------
>  1 file changed, 7 insertions(+), 25 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


