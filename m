From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Tue, 27 Oct 2015 01:32:36 +0000
Subject: [Intel-wired-lan] [next-queue 6/6] fm10k: consistently refer
	to	VLANs and VLAN IDs
In-Reply-To: <1445902327-6717-6-git-send-email-jacob.e.keller@intel.com>
References: <1445902327-6717-1-git-send-email-jacob.e.keller@intel.com>
 <1445902327-6717-6-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC6ABFA@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, October 26, 2015 4:32 PM
> To: Intel Wired LAN
> Subject: [Intel-wired-lan] [next-queue 6/6] fm10k: consistently refer to
> VLANs and VLAN IDs
> 
> Instead of using lowercase vlan, vid, or VID, always use VLAN or VLAN ID
> in comments when referring to VLANs. The original driver code was
> consistent, but recent patches have not been as consistent with this
> naming scheme.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k.h        |  4 ++--
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |  8 ++++----
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |  4 ++--
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c     | 10 +++++-----
>  4 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
