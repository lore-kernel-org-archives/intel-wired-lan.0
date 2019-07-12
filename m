From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jul 2019 18:08:01 +0000
Subject: [Intel-wired-lan] [PATCH 18/19] fm10k: convert
 NON_Q_VECTORS(hw) into NON_Q_VECTORS
In-Reply-To: <20190708231236.20516-19-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
 <20190708231236.20516-19-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40AC9B@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 18/19] fm10k: convert
> NON_Q_VECTORS(hw) into NON_Q_VECTORS
> 
> The driver currently uses a macro to decide whether we should use
> NON_Q_VECTORS_PF or NON_Q_VECTORS_VF.
> 
> However, we also define NON_Q_VECTORS_VF to the same value as
> NON_Q_VECTORS_PF. This means that the macro NON_Q_VECTORS(hw) will
> always return the same value.
> 
> Let's just remove this macro, and replace it directly with an enum value on
> the enum non_q_vectors.
> 
> This was detected by cppcheck and fixes the following warnings when
> building with BUILD=KERNEL
> 
> [fm10k_ethtool.c:1123]: (style) Same value in both branches of ternary
> operator.
> 
> [fm10k_ethtool.c:1142]: (style) Same value in both branches of ternary
> operator.
> 
> [fm10k_main.c:1826]: (style) Same value in both branches of ternary
> operator.
> 
> [fm10k_main.c:1849]: (style) Same value in both branches of ternary
> operator.
> 
> [fm10k_main.c:1858]: (style) Same value in both branches of ternary
> operator.
> 
> [fm10k_pci.c:901]: (style) Same value in both branches of ternary operator.
> 
> [fm10k_pci.c:1040]: (style) Same value in both branches of ternary operator.
> 
> [fm10k_pci.c:1726]: (style) Same value in both branches of ternary operator.
> 
> [fm10k_pci.c:1763]: (style) Same value in both branches of ternary operator.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k.h         | 10 +++-------
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |  6 ++----
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c    |  4 ++--
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c     |  9 ++++-----
>  4 files changed, 11 insertions(+), 18 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


