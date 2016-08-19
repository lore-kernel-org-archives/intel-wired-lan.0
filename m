From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Aug 2016 22:00:02 +0000
Subject: [Intel-wired-lan] [PATCH v1 3/3] i40e: use configured RSS key
 and	lookup table in i40e_vsi_config_rss
In-Reply-To: <20160719232331.31422-4-jacob.e.keller@intel.com>
References: <20160719232331.31422-1-jacob.e.keller@intel.com>
 <20160719232331.31422-4-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F9474@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, July 19, 2016 4:24 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v1 3/3] i40e: use configured RSS key and
> lookup table in i40e_vsi_config_rss
> 
> A previous refactor added support to store user configuration for VSIs, so
> that extra VSIs such as for VMDq can use this information when configuring.
> Unfortunately the i40e_vsi_config_rss function was missed in this refactor,
> and the values were being ignored. Fix this by checking for the fields and
> using those instead of always using the default values.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


