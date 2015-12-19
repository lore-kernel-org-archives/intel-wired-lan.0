From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 19 Dec 2015 03:24:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] igb: Remove unnecessary
 flag setting in igb_set_flag_queue_pairs()
In-Reply-To: <1449827040-1806-1-git-send-email-suzuki_shota_t3@lab.ntt.co.jp>
References: <1449827040-1806-1-git-send-email-suzuki_shota_t3@lab.ntt.co.jp>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E3134E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [netdev-owner at vger.kernel.org] on behalf of Shota Suzuki 
> [suzuki_shota_t3 at lab.ntt.co.jp]
> Sent: Friday, December 11, 2015 1:43 AM
> To: Kirsher, Jeffrey T; Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald C; 
> Ronciak, John; Williams, Mitch A; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: suzuki_shota_t3 at lab.ntt.co.jp
> Subject: [PATCH net-next 1/2] igb: Remove unnecessary flag setting in igb_set_flag_queue_pairs()
> 
> If VFs are enabled (max_vfs >= 1), both max_rss_queues and
> adapter->rss_queues are set to 2 in the case of e1000_82576.
> In this case, IGB_FLAG_QUEUE_PAIRS is always set in the default block as a
> result of fall-through, thus setting it in the e1000_82576 block is not
> necessary.

> Signed-off-by: Shota Suzuki <suzuki_shota_t3@lab.ntt.co.jp>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 8 --------
>  1 file changed, 8 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
