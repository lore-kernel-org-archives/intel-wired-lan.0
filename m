From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 16 Oct 2015 23:41:03 +0000
Subject: [Intel-wired-lan] [next-queue v5 01/17] fm10k:
	conditionally	compile DCB and DebugFS support
In-Reply-To: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC552C7@ORSMSX105.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue v5 01/17] fm10k: conditionally
> compile DCB and DebugFS support
> 
> Rather than wrapping fm10k_dcbnl.c and fm10k_debugfs.c support with
>  #ifdef blocks, just conditionally include the .o files in the Makefile.
> Also, since we're modifying it, update the copyright year on the
> Makefile.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/Makefile        | 20 +++++++++++++++----
> -
>  drivers/net/ethernet/intel/fm10k/fm10k.h         |  4 ++++
>  drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c   |  4 ----
>  drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c |  4 ----
>  4 files changed, 19 insertions(+), 13 deletions(-)

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
