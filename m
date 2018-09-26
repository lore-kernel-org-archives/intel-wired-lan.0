From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 17:05:51 +0000
Subject: [Intel-wired-lan] [PATCH 13/16] ice: Split irq_tracker into
 sw_irq_tracker and hw_irq_tracker
In-Reply-To: <20180920002319.10971-14-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-14-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC5D1@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 13/16] ice: Split irq_tracker into
> sw_irq_tracker and hw_irq_tracker
> 
> From: Preethi Banala <preethi.banala@intel.com>
> 
> For the PF driver, when mapping interrupts to queues, we need to request
> IRQs from the kernel and and we also have to allocate interrupts from the
> device.
> 
> Similarly, when the VF driver (iavf.ko) initializes, it requests the kernel IRQs
> that it needs but it can't directly allocate interrupts in the device.
> Instead, it sends a mailbox message to the ice driver, which then allocates
> interrupts in the device on the VF driver's behalf.
> 
> Currently both these cases end up having to reserve entries in
> pf->irq_tracker but irq_tracker itself is sized based on how many
> pf->vectors
> the PF driver needs. Under the right circumstances, the VF driver can fail to
> get entries in irq_tracker, which will result in the VF driver failing probe.
> 
> To fix this, sw_irq_tracker and hw_irq_tracker are introduced. The
> sw_irq_tracker tracks only the PF's IRQ request and doesn't play any role in
> VF init. hw_irq_tracker represents the device's interrupt space.
> When interrupts have to be allocated in the device for either PF or VF,
> hw_irq_tracker will be looked up to see if the device has run out of
> interrupts.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote
> commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  21 ++++--
>  drivers/net/ethernet/intel/ice/ice_lib.c  |  75 +++++++++++++------
> drivers/net/ethernet/intel/ice/ice_main.c | 116 +++++++++++++++++++++-
> --------
>  3 files changed, 148 insertions(+), 64 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


