From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jul 2019 18:07:27 +0000
Subject: [Intel-wired-lan] [PATCH 17/19] fm10k: mark unused parameters
 with __always_unused
In-Reply-To: <20190708231236.20516-18-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
 <20190708231236.20516-18-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40AC8B@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 17/19] fm10k: mark unused parameters
> with __always_unused
> 
> Several functions in the fm10k driver have specific function templates, as
> they are used as function pointers. The parameters in these functions are
> not always used. Explicitly mark unused parameters with the
> __always_unused macro, so that the compiler will not warn about them
> when building with the -Wunused-parameter warning enabled.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_mbx.c  |  5 ++--
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c   | 10 ++++----
>  drivers/net/ethernet/intel/fm10k/fm10k_tlv.c  |  7 +++---
> drivers/net/ethernet/intel/fm10k/fm10k_type.h |  2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.c   | 25 +++++++++++--------
>  5 files changed, 28 insertions(+), 21 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


