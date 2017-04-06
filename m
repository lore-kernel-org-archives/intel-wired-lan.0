From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 21:49:43 +0000
Subject: [Intel-wired-lan] [next S66 v2 09/11] i40e/i40evf: Add support
 for	using order 1 pages with a 3K buffer
In-Reply-To: <20170405115103.67374-9-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
 <20170405115103.67374-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B190@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 5, 2017 4:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S66 v2 09/11] i40e/i40evf: Add support for
> using order 1 pages with a 3K buffer
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> There are situations where adding padding to the front and back of an Rx
> buffer will require that we add additional padding.  Specifically if
> NET_IP_ALIGN is non-zero, or the MTU size is larger than 7.5K we would
> need to use 2K buffers which leaves us with no room for the padding.
> 
> To preemptively address these cases I am adding support for 3K buffers to
> the Rx path so that we can provide the additional padding needed in the
> event of NET_IP_ALIGN being non-zero or a cache line being greater than 64.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I938bc1ba611285428df39a613cd66f98e60b55c7
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     |  3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     | 27 +++++++++++++----------
> --
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h     | 12 +++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   | 27 +++++++++++++---------
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h   | 12 +++++++++++
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |  6 ++++++
>  6 files changed, 60 insertions(+), 27 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


