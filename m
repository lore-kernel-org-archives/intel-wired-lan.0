From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 27 May 2017 01:21:36 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: use disable_hardirq() also
 for MSIX vectors in e1000_netpoll()
In-Reply-To: <149517832870.37403.16008624383220981105.stgit@buzz>
References: <149517832870.37403.16008624383220981105.stgit@buzz>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5FC04C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Konstantin Khlebnikov
> Sent: Friday, May 19, 2017 12:19 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey
> T <jeffrey.t.kirsher@intel.com>
> Cc: Dave Jones <davej@codemonkey.org.uk>; WANG Cong
> <xiyou.wangcong@gmail.com>; David S. Miller <davem@davemloft.net>;
> Sabrina Dubroca <sd@queasysnail.net>
> Subject: [PATCH] e1000e: use disable_hardirq() also for MSIX vectors in
> e1000_netpoll()
> 
> Replace disable_irq() which waits for threaded irq handlers with
> disable_hardirq() which waits only for hardirq part.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 311191297125 ("e1000: use disable_hardirq() for e1000_netpoll()")
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

