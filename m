From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 May 2019 21:46:16 +0000
Subject: [Intel-wired-lan] [next PATCH S4 iavf 6/9] iavf: rename
 iavf_client.h defines to match driver name
In-Reply-To: <20190417221737.11460-6-alice.michael@intel.com>
References: <20190417221737.11460-1-alice.michael@intel.com>
 <20190417221737.11460-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C4BA@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S4 iavf 6/9] iavf: rename iavf_client.h
> defines to match driver name
> 
> The defines in iavf_client.h were still vastly i40e, and they should be iavf.
> 
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |   2 +-
>  drivers/net/ethernet/intel/iavf/iavf_client.c |  84 +++++++-------
> drivers/net/ethernet/intel/iavf/iavf_client.h | 104 +++++++++---------
>  3 files changed, 95 insertions(+), 95 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


