From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jul 2019 18:05:03 +0000
Subject: [Intel-wired-lan] [PATCH 12/19] fm10k: remove unnecessary
 variable initializer
In-Reply-To: <20190708231236.20516-13-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
 <20190708231236.20516-13-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40AC3F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 12/19] fm10k: remove unnecessary
> variable initializer
> 
> The err variable in the fm10k_tlv_attr_parse function is initialized with zero.
> However, the function never reads err without first assigning it from a
> function call. Remove this unnecessary initialization.
> 
> This was detected by cppcheck and resolves the following warning produced
> by that tool:
> 
> [fm10k_tlv.c:498]: (style) Variable 'err' is assigned a value that is never used.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_tlv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


