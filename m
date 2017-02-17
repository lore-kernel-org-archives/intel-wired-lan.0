From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 17 Feb 2017 03:26:02 +0000
Subject: [Intel-wired-lan] [next PATCH v5 01/12] igb: Add support
	for	DMA_ATTR_WEAK_ORDERING
In-Reply-To: <20170207022522.9864.56952.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
 <20170207022522.9864.56952.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C59AB0F@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, February 6, 2017 6:25 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v5 01/12] igb: Add support for
> DMA_ATTR_WEAK_ORDERING
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Since we are already using DMA attributes in igb for Rx there is no reason
> why we can't also apply DMA_ATTR_WEAK_ORDERING which is needed on
> some
> platforms to improve performance.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |    3 +++
>  drivers/net/ethernet/intel/igb/igb_main.c |    6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
