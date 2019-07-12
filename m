From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jul 2019 18:06:03 +0000
Subject: [Intel-wired-lan] [PATCH 14/19] fm10k: remove needless
 initialization of size local variable
In-Reply-To: <20190708231236.20516-15-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
 <20190708231236.20516-15-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40AC5F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 14/19] fm10k: remove needless
> initialization of size local variable
> 
> The local variable 'size' in fm10k_dfwd_add_station is initialized, but is always
> re-assigned immediately before use. Remove this unnecessary initialization.
> 
> This was detected by cppcheck and resolves the following warning produced
> by that tool:
> 
> [fm10k_netdev.c:1466]: (style) Variable 'size' is assigned a value that is never
> used.
> 
> Change-Id: I6f6d1ba3b9b26c2ed6f434fbeeafbbda4b78db33
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Title: fm10k: remove needless initialization of size local variable
> Change-type: ImplementationChange
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


