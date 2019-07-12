From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jul 2019 18:06:32 +0000
Subject: [Intel-wired-lan] [PATCH 15/19] fm10k: explicitly return 0 on
 success path in function
In-Reply-To: <20190708231236.20516-16-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
 <20190708231236.20516-16-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40AC6B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, July 8, 2019 4:13 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 15/19] fm10k: explicitly return 0 on success
> path in function
> 
> In the fm10k_handle_resume function, return 0 explicitly at the end of the
> function instead of returning the err value.
> 
> This was detected by cppcheck and resolves the following style warning
> produced by that tool:
> 
> [fm10k_pci.c:2768] -> [fm10k_pci.c:2787]: (warning) Identical condition 'err',
> second condition is always false
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


