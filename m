From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 16 Oct 2015 23:41:55 +0000
Subject: [Intel-wired-lan] [next-queue v5 02/17] fm10k: set netdev
 features	in one location
In-Reply-To: <1445018231-3196-2-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-2-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC5534F@ORSMSX105.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue v5 02/17] fm10k: set netdev features
> in one location
> 
> Don't change netdev hw_features later in fm10k_probe, instead set all
> values inside fm10k_alloc_netdev. To do so, we need to know the MAC
> type
> (whether it is PF or VF) in order to determine what to do. This helps
> ensure that all logic regarding features is co-located.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k.h        |  2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 31
> +++++++++++++++----------
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |  9 +------
>  3 files changed, 21 insertions(+), 21 deletions(-)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>

