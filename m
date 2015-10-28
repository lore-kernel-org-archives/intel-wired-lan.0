From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Oct 2015 21:58:23 +0000
Subject: [Intel-wired-lan] [next PATCH S20 14/15] i40evf: allocate
	ring	structs dynamically
In-Reply-To: <1445903081-155893-15-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-15-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D48B3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, October 26, 2015 4:45 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S20 14/15] i40evf: allocate ring structs
> dynamically
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Instead of awkwardly keeping a fixed array of pointers in the adapter struct
> and then allocating ring structs individually, just keep a single pointer and
> allocate a single blob for the arrays. This simplifies code, shrinks the adapter
> structure, and future-proofs the driver by not limiting the number of rings
> we can handle.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I31334ff911a6474954232cfe4bc98ccca3c769ff
> 
> ---
> Testing-hints: Ensure the driver loads and passes traffic, and unloads
> properly.
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  2 +-
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  4 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  8 +--
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 57 +++++++++++--------
> ---
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 10 ++--
>  5 files changed, 40 insertions(+), 41 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, driver loads and unloads properly and passes traffic.
