From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 15 Feb 2018 03:23:36 +0000
Subject: [Intel-wired-lan] [PATCH net-queue 2/3] e1000e: Fix queue
 interrupt re-raising in Other interrupt.
In-Reply-To: <20180208064714.6042-2-bpoirier@suse.com>
References: <20180208064714.6042-1-bpoirier@suse.com>
 <20180208064714.6042-2-bpoirier@suse.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7E62BB@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Benjamin Poirier
> Sent: Wednesday, February 7, 2018 10:47 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-queue 2/3] e1000e: Fix queue
> interrupt re-raising in Other interrupt.
> 
> restores the ICS write for rx/tx queue interrupts which was present before
> commit 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt",
> v4.5-rc1) but was not restored in commit 4aea7a5c5e94 ("e1000e: Avoid
> receiver overrun interrupt bursts", v4.15-rc1).
> 
> This re-raises the queue interrupts in case the txq or rxq bits were set in
> ICR and the Other interrupt handler read and cleared ICR before the queue
> interrupt was raised.
> 
> Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
