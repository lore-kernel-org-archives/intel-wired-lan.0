From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 21 Mar 2018 18:03:07 +0000
Subject: [Intel-wired-lan] [PATCH S88 3/8] i40e: Close client on suspend
 and restore client MSIx on resume
In-Reply-To: <20180314181918.21582-3-jeffrey.t.kirsher@intel.com>
References: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
 <20180314181918.21582-3-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94D24A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, March 14, 2018 11:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Saleem, Shiraz <shiraz.saleem@intel.com>
> Subject: [Intel-wired-lan] [PATCH S88 3/8] i40e: Close client on suspend and
> restore client MSIx on resume
> 
> From: Shiraz Saleem <shiraz.saleem@intel.com>
> 
> During suspend client MSIx vectors are freed while they are still in use
> causing a crash on entering S3.
> 
> Fix this calling client close before freeing up its MSIx vectors.
> Also update the client MSIx vectors on resume before client open is called.
> 
> Fixes commit b980c0634fe5 ("i40e: shutdown all IRQs and disable MSI-X
> when suspended")
> 
> Reported-by: Stefan Assmann <sassmann@redhat.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 16 +++++++++++++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 ++++++++
>  3 files changed, 22 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


