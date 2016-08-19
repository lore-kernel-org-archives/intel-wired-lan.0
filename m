From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Aug 2016 21:58:59 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/3] i40e: move
	i40e_vsi_config_rss	below i40e_get_rss_aq
In-Reply-To: <20160719232331.31422-2-jacob.e.keller@intel.com>
References: <20160719232331.31422-1-jacob.e.keller@intel.com>
 <20160719232331.31422-2-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F945C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, July 19, 2016 4:23 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v1 1/3] i40e: move i40e_vsi_config_rss
> below i40e_get_rss_aq
> 
> Move this function below the two functions related to configuring RSS via the
> admin queue. This helps co-locate the two functions, and made it easier to
> spot a bug in the first i40e_config_rss_aq function as compared to the
> i40e_get_rss_aq function.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 54 ++++++++++++++----------
> -----
>  1 file changed, 27 insertions(+), 27 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


