From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 May 2019 22:29:06 +0000
Subject: [Intel-wired-lan] [next PATCH S5 iavf 11/11] iavf: allow null
 RX descriptors
In-Reply-To: <20190514173709.62431-11-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
 <20190514173709.62431-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DB797@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, May 14, 2019 10:37 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S5 iavf 11/11] iavf: allow null RX
> descriptors
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> In some circumstances, the hardware can hand us a null receive descriptor,
> with no data attached but otherwise valid. Unfortunately, the driver was ill-
> equipped to handle such an event, and would stop processing packets at that
> point.
> 
> To fix this, use the Descriptor Done bit instead of the size to determine
> whether or not a descriptor is ready to be processed. Add some checks to
> allow for unused buffers.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


