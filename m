From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Jul 2019 17:21:04 +0000
Subject: [Intel-wired-lan] [PATCH v2 03/10] xsk: add support to allow
 unaligned chunk placement
In-Reply-To: <20190716030637.5634-4-kevin.laatz@intel.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
 <20190716030637.5634-1-kevin.laatz@intel.com>
 <20190716030637.5634-4-kevin.laatz@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40C31D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Kevin Laatz
> Sent: Monday, July 15, 2019 8:07 PM
> To: netdev at vger.kernel.org; ast at kernel.org; daniel at iogearbox.net; Topel,
> Bjorn <bjorn.topel@intel.com>; Karlsson, Magnus
> <magnus.karlsson@intel.com>; jakub.kicinski at netronome.com;
> jonathan.lemon at gmail.com
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Loftus, Ciara
> <ciara.loftus@intel.com>; intel-wired-lan at lists.osuosl.org;
> bpf at vger.kernel.org; Laatz, Kevin <kevin.laatz@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 03/10] xsk: add support to allow
> unaligned chunk placement
> 
> Currently, addresses are chunk size aligned. This means, we are very
> restricted in terms of where we can place chunk within the umem. For
> example, if we have a chunk size of 2k, then our chunks can only be placed at
> 0,2k,4k,6k,8k... and so on (ie. every 2k starting from 0).
> 
> This patch introduces the ability to use unaligned chunks. With these
> changes, we are no longer bound to having to place chunks at a 2k (or
> whatever your chunk size is) interval. Since we are no longer dealing with
> aligned chunks, they can now cross page boundaries. Checks for page
> contiguity have been added in order to keep track of which pages are
> followed by a physically contiguous page.
> 
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> ---
> v2:
>   - Add checks for the flags coming from userspace
>   - Fix how we get chunk_size in xsk_diag.c
>   - Add defines for masking the new descriptor format
>   - Modified the rx functions to use new descriptor format
>   - Modified the tx functions to use new descriptor format
> ---
>  include/net/xdp_sock.h      |  2 +
>  include/uapi/linux/if_xdp.h |  9 ++++
>  net/xdp/xdp_umem.c          | 17 ++++---
>  net/xdp/xsk.c               | 89 ++++++++++++++++++++++++++++++-------
>  net/xdp/xsk_diag.c          |  2 +-
>  net/xdp/xsk_queue.h         | 70 +++++++++++++++++++++++++----
>  6 files changed, 159 insertions(+), 30 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


