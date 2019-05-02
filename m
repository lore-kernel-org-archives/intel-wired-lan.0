From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 May 2019 21:46:42 +0000
Subject: [Intel-wired-lan] [next PATCH S4 iavf 7/9] iavf: change
 remaining i40e defines to be iavf
In-Reply-To: <20190417221737.11460-7-alice.michael@intel.com>
References: <20190417221737.11460-1-alice.michael@intel.com>
 <20190417221737.11460-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C4CD@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 17, 2019 3:18 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S4 iavf 7/9] iavf: change remaining
> i40e defines to be iavf
> 
> There were a couple of eroneously missed i40e names to update to iavf left
> after the larger chunks.  Updated them seperately so now they should all be
> aligned as iavf.
> 
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_adminq.c | 96 +++++++++----------
> drivers/net/ethernet/intel/iavf/iavf_adminq.h |  4 +-
>  drivers/net/ethernet/intel/iavf/iavf_type.h   |  2 +-
>  3 files changed, 51 insertions(+), 51 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


