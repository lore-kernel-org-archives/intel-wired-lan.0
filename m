From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Oct 2015 18:41:14 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] i40e/i40evf:
	use	napi_schedule_irqoff()
In-Reply-To: <20150929221950.3388.63535.stgit@ahduyck-vm-fedora22>
References: <20150929215117.3388.48642.stgit@ahduyck-vm-fedora22>
 <20150929221950.3388.63535.stgit@ahduyck-vm-fedora22>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B3109@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, September 29, 2015 3:20 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/3] i40e/i40evf: use
> napi_schedule_irqoff()
> 
> The i40e_intr and i40e/i40evf_msix_clean_rings functions run from hard
> interrupt context or with interrupts already disabled in netpoll.
> 
> They can use napi_schedule_irqoff() instead of napi_schedule()
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     |    6 ++++--
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |    2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
