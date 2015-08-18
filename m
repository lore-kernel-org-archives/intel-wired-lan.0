From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 18 Aug 2015 02:54:28 +0000
Subject: [Intel-wired-lan] [PATCH] e100: Add a check after
 pci_pool_create	to avoid null pointer dereference
In-Reply-To: <1438568228-13288-1-git-send-email-baijiaju1990@163.com>
References: <1438568228-13288-1-git-send-email-baijiaju1990@163.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81AE873D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jia-Ju Bai
> Sent: Sunday, August 02, 2015 7:17 PM
> To: Kirsher, Jeffrey T; Brandeburg, Jesse
> Cc: netdev at vger.kernel.org; Jia-Ju Bai; intel-wired-lan at lists.osuosl.org;
> linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] e100: Add a check after pci_pool_create
> to avoid null pointer dereference
> 
> The driver lacks the check of nic->cbs_pool after pci_pool_create
> in e100_probe. When this function is failed, a null pointer dereference
> occurs when pci_pool_alloc uses nic->cbs_pool in e100_alloc_cbs.
> This patch adds a check and related error handling code to fix it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
> ---
>  drivers/net/ethernet/intel/e100.c |    7 +++++++
>  1 file changed, 7 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
