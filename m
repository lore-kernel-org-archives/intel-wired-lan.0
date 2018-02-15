From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 15 Feb 2018 03:23:12 +0000
Subject: [Intel-wired-lan] [PATCH net-queue 1/3] Partial revert "e1000e:
 Avoid receiver overrun interrupt bursts"
In-Reply-To: <20180208064714.6042-1-bpoirier@suse.com>
References: <20180208064714.6042-1-bpoirier@suse.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7E62AD@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-queue 1/3] Partial revert "e1000e:
> Avoid receiver overrun interrupt bursts"
> 
> This partially reverts commit 4aea7a5c5e940c1723add439f4088844cd26196d.
> 
> We keep the fix for the first part of the problem (1) described in the log
> of that commit, that is to read ICR in the other interrupt handler. We
> remove the fix for the second part of the problem (2), Other interrupt
> throttling.
> 
> Bursts of "Other" interrupts may once again occur during rxo (receive
> overflow) traffic conditions. This is deemed acceptable in the interest of
> avoiding unforeseen fallout from changes that are not strictly necessary.
> As discussed, the e1000e driver should be in "maintenance mode".
> 
> Link: https://www.spinics.net/lists/netdev/msg480675.html
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
