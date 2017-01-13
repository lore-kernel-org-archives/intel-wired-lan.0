From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 13 Jan 2017 20:57:15 +0000
Subject: [Intel-wired-lan] [next PATCH v4 1/3] mm: Rename
 __alloc_page_frag to page_frag_alloc and __free_page_frag to page_frag_free
In-Reply-To: <20170104023854.13451.67390.stgit@localhost.localdomain>
References: <20170104023620.13451.80691.stgit@localhost.localdomain>
 <20170104023854.13451.67390.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5B444@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, January 03, 2017 6:40 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: linux-mm at kvack.org; akpm at linux-foundation.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [next PATCH v4 1/3] mm: Rename
> __alloc_page_frag to page_frag_alloc and __free_page_frag to
> page_frag_free
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch renames the page frag functions to be more consistent with other
> APIs.  Specifically we place the name page_frag first in the name and then
> have either an alloc or free call name that we append as the suffix.  This
> makes it a bit clearer in terms of naming.
> 
> In addition we drop the leading double underscores since we are technically
> no longer a backing interface and instead the front end that is called from the
> networking APIs.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> v2: Fixed a comparison between a void* and 0 due to copy/paste from
> free_pages
> v3: Dropped changes to function and make this a rename patch only.
>     This fixes a small performance regression I saw in some tests.
> v4: Added back page_frag_alloc which had leaked through to patch 2 after
>     I had tried reordering them in my own queue.
> 
>  include/linux/gfp.h    |    6 +++---
>  include/linux/skbuff.h |    2 +-
>  mm/page_alloc.c        |   10 +++++-----
>  net/core/skbuff.c      |    8 ++++----
>  4 files changed, 13 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


