From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 13 Jan 2017 20:58:47 +0000
Subject: [Intel-wired-lan] [next PATCH v4 3/3] mm: Add documentation
	for	page fragment APIs
In-Reply-To: <20170104024157.13451.6758.stgit@localhost.localdomain>
References: <20170104023620.13451.80691.stgit@localhost.localdomain>
 <20170104024157.13451.6758.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5B464@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v4 3/3] mm: Add documentation for
> page fragment APIs
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This is a first pass at trying to add documentation for the page_frag APIs.
> They may still change over time but for now I thought I would try to get these
> documented so that as more network drivers and stack calls make use of
> them we have one central spot to document how they are meant to be
> used.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> v2,v3: No change
> 
>  Documentation/vm/page_frags |   42
> ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


