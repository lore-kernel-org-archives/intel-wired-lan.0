From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 17:33:52 +0000
Subject: [Intel-wired-lan] [next PATCH v2 03/11] ixgbe: Update driver to
 make use of DMA attributes in Rx path
In-Reply-To: <20170117163550.5423.60153.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
 <20170117163550.5423.60153.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D670@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, January 17, 2017 8:36 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v2 03/11] ixgbe: Update driver to
> make use of DMA attributes in Rx path
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch adds support for DMA_ATTR_SKIP_CPU_SYNC and
> DMA_ATTR_WEAK_ORDERING.  By enabling both of these for the Rx path
> we are able to see performance improvements on architectures that
> implement either one due to the fact that page mapping and unmapping
> only has to sync what is actually being used instead of the entire buffer.  In
> addition by enabling the weak ordering attribute enables a performance
> improvement for architectures that can associate a memory ordering with a
> DMA buffer such as Sparc.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    3 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   56 +++++++++++++++++-
> -------
>  2 files changed, 40 insertions(+), 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


