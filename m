From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 15 Feb 2018 03:23:57 +0000
Subject: [Intel-wired-lan] [PATCH net-queue 3/3] e1000e: Avoid missed
 interrupts following ICR read.
In-Reply-To: <20180208064714.6042-3-bpoirier@suse.com>
References: <20180208064714.6042-1-bpoirier@suse.com>
 <20180208064714.6042-3-bpoirier@suse.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7E62D1@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-queue 3/3] e1000e: Avoid missed
> interrupts following ICR read.
> 
> The 82574 specification update errata 12 states that interrupts may be
> missed if ICR is read while INT_ASSERTED is not set. Avoid that problem by
> setting all bits related to events that can trigger the Other interrupt in
> IMS.
> 
> The Other interrupt is raised for such events regardless of whether or not
> they are set in IMS. However, only when they are set is the INT_ASSERTED
> bit also set in ICR.
> 
> By doing this, we ensure that INT_ASSERTED is always set when we read ICR
> in e1000_msix_other() and steer clear of the errata. This also ensures that
> ICR will automatically be cleared on read, therefore we no longer need to
> clear bits explicitly.
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/defines.h | 21
> ++++++++++++++++++++-
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 11 ++++-------
>  2 files changed, 24 insertions(+), 8 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
