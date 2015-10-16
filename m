From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 16 Oct 2015 23:40:54 +0000
Subject: [Intel-wired-lan] [next-queue v5 03/17] fm10k: reset max_queues
 on	init_hw_vf failure
In-Reply-To: <1445018231-3196-3-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-3-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC552B1@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, October 16, 2015 10:57 AM
> To: Intel Wired LAN
> Subject: [Intel-wired-lan] [next-queue v5 03/17] fm10k: reset max_queues
> on init_hw_vf failure
> 
> VF drivers must detect how many queues are available. Previously, the
> driver assumed that each VF has at minimum 1 queue. This assumption is
> incorrect, since it is possible that the PF has not yet assigned the
> queues to the VF by the time the VF checks. To resolve this, we added a
> check first to ensure that the first queue is infact owned by the VF at
> init_hw_vf time. However, the code flow did not reset hw-
> >mac.max_queues
> to 0. In some cases, such as during reinit flows, we call init_hw_vf
> without clearing the previous value of hw->mac.max_queues. Due to this,
> when init_hw_vf errors out, if its error code is not properly handled
> the VF driver may still believe it has queues which no longer belong to
> it. Fix this by clearing the hw->mac.max_queues on exit due to errors.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>

