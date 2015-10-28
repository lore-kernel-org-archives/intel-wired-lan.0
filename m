From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Oct 2015 21:49:48 +0000
Subject: [Intel-wired-lan] [next PATCH S20 13/15] i40evf: allocate
	queue	vectors dynamically
In-Reply-To: <1445903081-155893-14-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-14-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D48A2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>  -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, October 26, 2015 4:45 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S20 13/15] i40evf: allocate queue
> vectors dynamically
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Change the queue_vector array from a statically-sized member of the
> adapter structure to a dynamically-allocated and -sized array.
> 
> This reduces the size of the adapter structure, and allows us to support any
> number of queue vectors in the future without changing the code.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I08dc622cb2f2ad01e832e51c1ad9b86524730693
> 
> ---
> Testing-hints: Open and close the interface several times and ensure that
> traffic continues to pass.
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  5 +--
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  2 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 38 ++++++++++----------
> --
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  2 +-
>  4 files changed, 21 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, interface passes traffic after opening and closing interface
