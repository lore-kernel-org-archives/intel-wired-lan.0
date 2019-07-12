From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jul 2019 18:08:28 +0000
Subject: [Intel-wired-lan] [PATCH 19/19] fm10k: fix fm10k_get_fault_pf
 to read correct address
In-Reply-To: <20190708231236.20516-20-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
 <20190708231236.20516-20-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40ACA7@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 19/19] fm10k: fix fm10k_get_fault_pf to
> read correct address
> 
> Fix assignment of the FM10K_FAULT_ADDR_LO register into fault->address
> by using a bit-wise |= operation. Without this, the low address is completely
> overwriting the high potion of the address. This caused the fault to
> incorrectly return only the lower 32 bits of the fault address.
> 
> This issue was detected by cppcheck and resolves the following warnings
> produced by that tool:
> 
> [fm10k_pf.c:1668] -> [fm10k_pf.c:1670]: (style) Variable 'fault->address' is
> reassigned a value before the old one has been used.
> 
> [fm10k_pf.c:1669] -> [fm10k_pf.c:1670]: (style) Variable 'fault->address' is
> reassigned a value before the old one has been used.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


