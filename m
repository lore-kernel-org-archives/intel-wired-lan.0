From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 02 Aug 2018 09:58:31 -0700
Subject: [Intel-wired-lan] [E1000-devel] [PATCH] igb: CPU0 latency and
 updating statistics
In-Reply-To: <1533108587.16601.56.camel@atviedlbe741.rss.d3s.at.thales>
References: <1533108587.16601.56.camel@atviedlbe741.rss.d3s.at.thales>
Message-ID: <6a0523e73e5a9a2fe23caeb9a65e505e788d6012.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-08-01 at 07:29 +0000, JABLONSKY Jan wrote:
> The Watchdog workqueue in igb driver is scheduled every 2s for each 
> network interface. That includes updating a statistics protected by 
> spinlock. Function igb_update_stats in this case will be protected 
> against preemption. According to number of a statistics registers 
> (cca 60), processing this function might cause additional cpu load
>  on CPU0.
> 
> In case of statistics spinlock may be replaced with mutex, which 
> reduce latency on CPU0.
> 
> 
> # Measurements
> Measurements were performed on Intel Atom E3950 (Quad-Core), 
> E3930 (Dual-Core)
> 
> # Cyclictest
> High latency is always on CPU0 which might be in range 
> from 70us to 140us (sometimes higher)
> 
> 
> # cyclictest -l1000000 -Smp90 -i200 -q
> 
> # E3930
> # default
> T: 0 ( 1745) P:90 I:200 C:1000000 Min: 2 Act: 3 Avg: 3 Max: 72
> T: 1 ( 1746) P:90 I:700 C: 285737 Min: 3 Act: 4 Avg: 3 Max: 13
> 
> # with patch
> T: 0 (  932) P:90 I:200 C:1000000 Min: 2 Act: 3 Avg: 3 Max: 22
> T: 1 (  933) P:90 I:700 C: 285736 Min: 2 Act: 3 Avg: 3 Max: 12
> 
> 
> # E3950
> # default
> T: 0 ( 1103) P:90 I:200 C:1000000 Min: 2 Act: 2 Avg: 2 Max: 89
> T: 1 ( 1104) P:90 I:700 C: 285738 Min: 2 Act: 4 Avg: 2 Max: 9
> T: 2 ( 1105) P:90 I:1200 C: 166678 Min: 2 Act: 5 Avg: 3 Max: 22
> T: 3 ( 1106) P:90 I:1700 C: 117653 Min: 2 Act: 6 Avg: 2 Max: 13
> 
> # with patch
> T: 0 (  879) P:90 I:200 C:1000000 Min: 2 Act: 3 Avg: 3 Max: 26
> T: 1 (  880) P:90 I:700 C: 285729 Min: 3 Act: 4 Avg: 3 Max: 22
> T: 2 (  881) P:90 I:1200 C: 166672 Min: 3 Act: 7 Avg: 3 Max: 24
> T: 3 (  882) P:90 I:1700 C: 117649 Min: 3 Act: 7 Avg: 3 Max: 8
> 
> 
> Additionally I think updating statistics and watchdog task should 
> be implemented in 2 separated ways
> 
> Patch is created against a linux-4.4
> 
> Reviewed also by: Bernhard Kaindl  <bernhard.kaindl@thalesgroup.com>
> 
> Signed-off-by: Jan Jablonsky <jan.jablonsky@thalesgroup.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |  2 +-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |  4 ++--
>  drivers/net/ethernet/intel/igb/igb_main.c    | 14 +++++++-------
>  3 files changed, 10 insertions(+), 10 deletions(-)

NACK, as is.  This patch is malformed, as well as does not apply to the
current net-next tree.

Since the jist of this change is to wrap statistical updates with mutex
lock versus spin locks, I will put together a patch agains the latest
net-next tree for your review Jan.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180802/57c7fdca/attachment.asc>
