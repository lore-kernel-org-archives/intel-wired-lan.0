From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 16 Oct 2015 23:41:31 +0000
Subject: [Intel-wired-lan] [next-queue v5 12/17] fm10k:
	introduce	ITR_IS_ADAPTIVE macro
In-Reply-To: <1445018231-3196-12-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-12-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC55308@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, October 16, 2015 10:57 AM
> To: Intel Wired LAN
> Subject: [Intel-wired-lan] [next-queue v5 12/17] fm10k: introduce
> ITR_IS_ADAPTIVE macro
> 
> Define a macro for identifying when the itr value is dynamic or
> adaptive. The concept was taken from i40e. This helps make clear what
> the check is, and reduces the line length to something more reasonable
> in a few places.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k.h         | 2 ++
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 6 ++----
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c    | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>

