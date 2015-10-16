From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 16 Oct 2015 23:42:08 +0000
Subject: [Intel-wired-lan] [next-queue v5 14/17] fm10k: use macro
	for	default Tx and Rx ITR values
In-Reply-To: <1445018231-3196-14-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-14-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC55373@ORSMSX105.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue v5 14/17] fm10k: use macro for
> default Tx and Rx ITR values
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k.h         | 2 ++
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 4 ++--
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c     | 4 ++--
>  3 files changed, 6 insertions(+), 4 deletions(-)

Suggested-by: Bruce Allan <bruce.w.allan@intel.com>
Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>

