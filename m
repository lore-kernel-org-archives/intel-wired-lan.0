From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Aug 2018 22:05:23 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix driver behaviour after
 issuing VFLR
In-Reply-To: <20180731161600.75051-1-sebastianx.basierski@intel.com>
References: <20180731161600.75051-1-sebastianx.basierski@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DB42A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sebastian Basierski
> Sent: Tuesday, July 31, 2018 9:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix driver behaviour after issuing
> VFLR
> 
> Since VFLR doesn't clear VFMBMEM (VF Mailbox Memory) and is not re-
> enabling queues correctly we should fix this behavior.
> 
> Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
> ---
>  .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 26 +++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  1 +
>  2 files changed, 27 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


