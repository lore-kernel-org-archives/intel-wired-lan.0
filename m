From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 1 Nov 2018 19:26:22 +0000
Subject: [Intel-wired-lan] [PATCH][next] igc: fix error return handling
 from call to netif_set_real_num_tx_queues
In-Reply-To: <20181019181615.27528-1-colin.king@canonical.com>
References: <20181019181615.27528-1-colin.king@canonical.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9659869C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Friday, October 19, 2018 11:16 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; David S . Miller <davem@davemloft.net>;
> intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][next] igc: fix error return handling from
> call to netif_set_real_num_tx_queues
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to netif_set_real_num_tx_queues is not assigning the error
> return to variable err even though the next line checks err for an
> error.  Fix this by adding the missing err assignment.
> 
> Detected by CoverityScan, CID#1474551 ("Logically dead code")
> 
> Fixes: 3df25e4c1e66 ("igc: Add interrupt support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
