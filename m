From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 18:39:53 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S27 12/15] i40e/i40evf: use
 pages	correctly in rx
In-Reply-To: <1452732712-12248-13-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
 <1452732712-12248-13-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F987B47@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, January 13, 2016 4:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S27 12/15] i40e/i40evf: use pages
> correctly in rx
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Refactor the packet split rx code to properly use half-pages for receives. The
> previous code was doing way more mapping and unmapping than it needed
> to, and wasn't properly using half-pages.
> 
> Increment the page use count each time we give a half-page to an skb,
> knowing that the stack will probably process and release the page before we
> need it again. Only free and reallocate pages if the count shows that both
> half-pages are in use. Add counters to track reallocations and page reuse.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I534b299196036b64be82b4861a0a4036310a8f22
> ---
> Testing Hints: Hammer the receive path and make sure it a) works and b)
> doesn't leak memory.
> 
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |   5 ++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 118 ++++++++++++++++-----
> ----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    |   2 +
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c  | 118 ++++++++++++++++----
> -----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h  |   2 +
>  5 files changed, 159 insertions(+), 86 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, receive path functions, no memory leaks observed
