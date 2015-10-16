From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 16 Oct 2015 23:41:46 +0000
Subject: [Intel-wired-lan] [next-queue v5 11/17] fm10k: Add support for
 ITR	scaling based on PCIe link speed
In-Reply-To: <1445018231-3196-11-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-11-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC55332@ORSMSX105.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue v5 11/17] fm10k: Add support for ITR
> scaling based on PCIe link speed
> 
> The Intel Ethernet Switch FM10000 Host Interface interrupt throttle
> timers are based on the PCIe link speed. Because of this, the value
> being programmed into the ITR registers must be scaled accordingly.
> 
> For the PF, this is as simple as reading the PCIe link speed and storing
> the result. However, in the case of SR-IOV, the VF's interrupt throttle
> timers are based on the link speed of the PF. However, the VF is unable
> to get the link speed information from its configuration space, so the
> PF must inform it of what scale to use.
> 
> Rather than pass this scale via mailbox message, take advantage of
> unused bits in the TDLEN register to pass the scale. It is the
> responsibility of the PF to program this for the VF while setting up the
> VF queues and the responsibility of the VF to get the information
> accordingly. This is preferable because it allows the VF to set up the
> interrupts properly during initialization and matches how the MAC
> address is passed in the TDBAL/TDBAH registers.
> 
> Since we're modifying fm10k_type.h, we may as well also update the
> copyright year.
> 
> Reported-by: Matthew Vick <matthew.vick@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c   | 22
> +++++++++++++++++++++-
>  drivers/net/ethernet/intel/fm10k/fm10k_type.h | 17
> ++++++++++++++++-
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.c   | 20
> ++++++++++++++++++--
>  3 files changed, 55 insertions(+), 4 deletions(-)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>

