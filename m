From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 16 Oct 2015 23:42:01 +0000
Subject: [Intel-wired-lan] [next-queue v5 05/17] fm10k: reinitialize
 queuing	scheme after calling init_hw
In-Reply-To: <1445018231-3196-5-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-5-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC5535B@ORSMSX105.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue v5 05/17] fm10k: reinitialize queuing
> scheme after calling init_hw
> 
> The init_hw function may fail, and in the case of VFs, it might change
> the number of maximum queues available. Thus, for every flow which
> checks init_hw, we need to ensure that we clear the queue scheme before,
> and initialize it after. The fm10k_io_slot_reset path will end up
> triggering a reset so fm10k_reinit needs this change. The
> fm10k_io_error_detected and fm10k_io_resume also need to properly
> clear
> and reinitialize the queue scheme.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>

