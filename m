From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Apr 2018 22:16:30 +0000
Subject: [Intel-wired-lan] [iwl next-queue PATCH 08/10] ixgbe/fm10k:
 Only support macvlan offload for types that support destination filtering
In-Reply-To: <20180403211635.7880.27194.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
 <20180403211635.7880.27194.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A95AF3F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, April 3, 2018 2:17 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [iwl next-queue PATCH 08/10] ixgbe/fm10k: Only
> support macvlan offload for types that support destination filtering
> 
> Both the ixgbe and fm10k drivers support destination filtering.
> 
> Instead of adding a ton of complexity to support either source or passthru
> mode we can instead just avoid offloading them for now. Doing this we avoid
> leaking packets into interfaces that aren't meant to receive them.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |    8 ++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |    7 +++++++
>  2 files changed, 15 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


