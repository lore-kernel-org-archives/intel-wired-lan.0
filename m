From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 13 Jan 2017 20:58:01 +0000
Subject: [Intel-wired-lan] [next PATCH v4 2/3] mm: Rename __page_frag
 functions to __page_frag_cache, drop order from drain
In-Reply-To: <20170104023954.13451.5678.stgit@localhost.localdomain>
References: <20170104023620.13451.80691.stgit@localhost.localdomain>
 <20170104023954.13451.5678.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5B454@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, January 03, 2017 6:42 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: linux-mm at kvack.org; akpm at linux-foundation.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [next PATCH v4 2/3] mm: Rename __page_frag
> functions to __page_frag_cache, drop order from drain
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch does two things.
> 
> First it goes through and renames the __page_frag prefixed functions to
> __page_frag_cache so that we can be clear that we are draining or refilling
> the cache, not the frags themselves.
> 
> Second we drop the order parameter from __page_frag_cache_drain since
> we don't actually need to pass it since all fragments are either order 0 or
> must be a compound page.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> v2: No change
> v3: No change (in theory)
> v4: Pulled out page_frag_alloc rename bits which had leaked through due to
> me
>     trying out reordering some patches in my own queue.
> 
>  drivers/net/ethernet/intel/igb/igb_main.c |    6 +++---
>  include/linux/gfp.h                       |    3 +--
>  mm/page_alloc.c                           |   13 +++++++------
>  3 files changed, 11 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


