From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jul 2019 18:00:33 +0000
Subject: [Intel-wired-lan] [PATCH 03/19] fm10k: reduce the scope of qv
 local variable
In-Reply-To: <20190708231236.20516-4-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
 <20190708231236.20516-4-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40ABB0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, July 8, 2019 4:12 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 03/19] fm10k: reduce the scope of qv local
> variable
> 
> Reduce the scope of the qv vector pointer local variable in the
> fm10k_set_coalesce function.
> 
> This was detected by cppcheck and resolves the following style warning
> produced by that tool:
> 
> [fm10k_ethtool.c:658]: (style) The scope of the variable 'qv' can be reduced.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


