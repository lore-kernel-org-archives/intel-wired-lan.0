From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 14:06:18 -0700
Subject: [Intel-wired-lan] [net-next 20/25] fm10k: Add support for ITR
 scaling based on PCIe link speed
In-Reply-To: <1428092835-16834-20-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-20-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428095178.2662.131.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> Fm10k's interrupt throttle timers are based on the PCIe link
> speed. Because of this, the value being programmed into the ITR
> registers must be scaled.
> 
> For the PF, this is as simple as reading the PCIe link speed and
> storing
> the result. However, in the case of SR-IOV, the VF's interrupt
> throttle
> timers are based on the link speed of the PF. However, the VF is
> unable
> to get the link speed information from its configuration space, so the
> PF must inform it of what scale to use.
> 
> Rather than pass this scale via mailbox message, take advantage of
> unused bits in the TDLEN register to pass the scale. It is the
> responsibility of the PF to program this for the VF while setting up
> the
> VF queues and the responsibility of the VF to get the information
> accordingly. This is preferable because it allows the VF to set up the
> interrupts properly during initialization and matches how the MAC
> address is passed in the TDBAL/TDBAH registers.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k.h      |  4 ++++
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c | 17 +++++++++++++----
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c  | 12 ++++++++++--
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c   | 16 +++++++++++++++-
>  drivers/net/ethernet/intel/fm10k/fm10k_type.h |  6 ++++++
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.c   | 11 +++++++++--
>  6 files changed, 57 insertions(+), 9 deletions(-)

I have applied to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/8670b4c5/attachment-0001.asc>
