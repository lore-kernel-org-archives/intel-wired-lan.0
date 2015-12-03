From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Dec 2015 19:44:41 +0000
Subject: [Intel-wired-lan] [PATCH v3 4/4] e1000e: Fix msi-x
	interrupt	automask
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81E25FEF@ORSMSX101.amr.corp.intel.com>
References: <1447113021-1611-1-git-send-email-bpoirier@suse.com>,
 <1447113021-1611-5-git-send-email-bpoirier@suse.com>,
 <309B89C4C689E141A5FF6A0C5FB2118B81E25FEF@ORSMSX101.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E27421@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Benjamin Poirier [bpoirier at suse.com]
> Sent: Monday, November 09, 2015 3:50 PM
> To: Kirsher, Jeffrey T
> Cc: Frank Steiner; linux-kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH v3 4/4] e1000e: Fix msi-x interrupt   automask
>
> Since the introduction of 82574 support in e1000e, the driver has worked
> on the assumption that msi-x interrupt generation is automatically
> disabled after each irq. As it turns out, this is not the case.
> Currently, rx interrupts can fire multiple times before and during napi
> processing. This can be a problem for users because frames that arrive
> in a certain window (after adapter->clean_rx() but before
> napi_complete_done() has cleared NAPI_STATE_SCHED) generate an interrupt
> which does not lead to napi_schedule(). These frames sit in the rx queue
> until another frame arrives (a tcp retransmit for example).
>
> While the EIAC and CTRL_EXT registers are properly configured for irq
> automask, the modification of IAM in e1000_configure_msix() is what
> prevents automask from working as intended.
>
> This patch removes that erroneous write and fixes interrupt rearming for
> tx interrupts. It also clears IAME from CTRL_EXT. This is not strictly
> necessary for operation of the driver but it is to avoid disruption from
> potential programs that access the registers directly, like `ethregs -c`.
>
> Reported-by: Frank Steiner <steiner-reg@bio.ifi.lmu.de>
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
