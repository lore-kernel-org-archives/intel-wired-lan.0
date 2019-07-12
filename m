From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jul 2019 18:07:01 +0000
Subject: [Intel-wired-lan] [PATCH 16/19] fm10k: cast page_addr to u8 *
 when incrementing it
In-Reply-To: <20190708231236.20516-17-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
 <20190708231236.20516-17-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40AC7B@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 16/19] fm10k: cast page_addr to u8 * when
> incrementing it
> 
> The page_addr variable is a void pointer. Incrementing it before calling
> prefetch is technically undefined. Fix this by casting it to a u8* pointer before
> incrementing it. This ensures that we increment the pointer value in byte
> units, instead of relying on this undefined behavior.
> 
> This was detected by cppcheck, and resolves the following warning produced
> by that tool:
> 
> [fm10k_main.c:328]: (portability) 'page_addr' is of type 'void *'. When using
> void pointers in calculations, the behaviour is undefined.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


