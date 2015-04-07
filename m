From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 07 Apr 2015 16:58:36 -0700
Subject: [Intel-wired-lan] [net-next S3 09/13] i40e/i40evf: Save
 WR_CSR_PROT field from DEV/FUNC capabilities
In-Reply-To: <1428450342-48517-9-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428451116.1860.1.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> From: Kevin Scott <kevin.c.scott@intel.com>
> 
> Store the 8 bytes of the WR_CSR_PROT field returned as part of the get
> device/function capabilities AQ command.
> 
> Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
> Change-ID: Ifcaeea2ff29885fa769e4f384c7db88a25e8afd0
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 5 +++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h | 1 +
>  3 files changed, 7 insertions(+)

Thanks Catherine, I have added your patch to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150407/cd8de579/attachment.asc>
