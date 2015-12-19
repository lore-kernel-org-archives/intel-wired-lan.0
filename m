From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 19 Dec 2015 03:25:41 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/2] igb: Unpair the queues
 when	changing the number of queues
In-Reply-To: <1449827040-1806-2-git-send-email-suzuki_shota_t3@lab.ntt.co.jp>
References: <1449827040-1806-1-git-send-email-suzuki_shota_t3@lab.ntt.co.jp>,
 <1449827040-1806-2-git-send-email-suzuki_shota_t3@lab.ntt.co.jp>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E3136B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Shota Suzuki 
> [suzuki_shota_t3 at lab.ntt.co.jp]
> Sent: Friday, December 11, 2015 1:44 AM
> To: Kirsher, Jeffrey T; Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald C; 
> Ronciak, John; Williams, Mitch A; intel-wired-lan at lists.osuosl.org; > netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next 2/2] igb: Unpair the queues when     changing the number of queues
> 
> By the commit 72ddef0506da ("igb: Fix oops caused by missing queue
> pairing"), the IGB_FLAG_QUEUE_PAIRS flag can now be set when changing the
> number of queues by "ethtool -L", but it is never cleared unless the igb
> driver is reloaded.
> This patch clears it if queue pairing becomes unnecessary as a result of
> "ethtool -L".
> 
> Signed-off-by: Shota Suzuki <suzuki_shota_t3@lab.ntt.co.jp>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
