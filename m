From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:11:06 +0000
Subject: [Intel-wired-lan] [PATCH S35 01/15] ice: Support UDP
 segmentation offload
In-Reply-To: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
Message-ID: <92ca5af5361141229c7ca2f6bed1d8f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, December 12, 2019 3:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S35 01/15] ice: Support UDP segmentation
> offload
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Based on the work done by Alex Duyck on other Intel drivers, add code to
> support UDP segmentation offload (USO) for the ice driver.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c |  3 ++-
> drivers/net/ethernet/intel/ice/ice_txrx.c | 15 ++++++++++++---
>  2 files changed, 14 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


