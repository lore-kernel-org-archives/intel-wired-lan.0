From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jul 2019 18:05:33 +0000
Subject: [Intel-wired-lan] [PATCH 13/19] fm10k: remove needless
 assignment of err local variable
In-Reply-To: <20190708231236.20516-14-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
 <20190708231236.20516-14-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40AC4E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 13/19] fm10k: remove needless
> assignment of err local variable
> 
> The local variable err in several functions in the fm10k_netdev.c file is
> initialized with a value that is never used. The err value is immediately re-
> assigned in all cases where it will be checked. Remove the unnecessary
> initializers.
> 
> This was detected by cppcheck and resolves the following warnings
> produced by that tool:
> 
> [fm10k_netdev.c:999] -> [fm10k_netdev.c:1004]: (style) Variable 'err' is
> reassigned a value before the old one has been used.
> 
> [fm10k_netdev.c:1019] -> [fm10k_netdev.c:1024]: (style) Variable 'err'
> is reassigned a value before the old one has been used.
> 
> [fm10k_netdev.c:64]: (style) Variable 'err' is assigned a value that is never
> used.
> 
> [fm10k_netdev.c:131]: (style) Variable 'err' is assigned a value that is never
> used.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


