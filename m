From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 12 May 2015 01:08:44 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: fix logical error
	in	flush_desc_rings
In-Reply-To: <1429719917-25985-1-git-send-email-yanirx.lubetkin@intel.com>
References: <1429719917-25985-1-git-send-email-yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DC2530@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Wednesday, April 22, 2015 9:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] e1000e: fix logical error in
> flush_desc_rings
> 
> the condition under which the flush should occur was reversed.
> The fix should be applied before any HW reset (unless followed by bus
> reset)
> and before any power state transition from D0.
> if E1000_FEXTNVM7_NEED_DESCRING_FLUSH bit is set in FEXTNVM7 and TDLEN > 0
> the tx ring should be flushed. (fixes ~95% of the hang states).
> if the E1000_FEXTNVM7_NEED_DESCRING_FLUSH did not clear, we should also
> flush the RX ring. Bug was caught by Alexander Duyck during a code review
> when examining this fix.
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
