From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 30 Oct 2015 00:13:14 +0000
Subject: [Intel-wired-lan] [next-queue v2] fm10k: initialize xps at
 driver	load
In-Reply-To: <1446151420-6632-1-git-send-email-jacob.e.keller@intel.com>
References: <1446151420-6632-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC6FA70@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Thursday, October 29, 2015 1:44 PM
> To: Intel Wired LAN
> Subject: [Intel-wired-lan] [next-queue v2] fm10k: initialize xps at driver load
> 
> Similar to ixgbe and i40e, initialize XPS on driver load so that we can
> take advantage of this kernel feature.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> 
> - v2
> * Fix patch application issue
> * Put xps initialization on Tx queues (instead of Rx)
> 
> This patch replaces the previous version currently on the queue, in
> place.
> 
>  drivers/net/ethernet/intel/fm10k/fm10k.h     |  3 +++
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 18 ++++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
