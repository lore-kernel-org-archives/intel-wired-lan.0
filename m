From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:07:54 +0000
Subject: [Intel-wired-lan] [PATCH S40 10/15] ice: Increase mailbox
 receive queue length to maximum
In-Reply-To: <20200227181505.61720-10-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-10-anthony.l.nguyen@intel.com>
Message-ID: <11f56affff7b4fb1afc5f7315f3daff5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 10/15] ice: Increase mailbox receive
> queue length to maximum
> 
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> Currently the PF's mailbox receive queue is only 512 entries. This fine, but
> considering that all VF's mailbox send queues funnel into the PF's single
> mailbox receive queue, let's increase it to the maximum size. This will help
> prevent any possible bottleneck/slowdown occurring from the PF's mailbox
> receive queue being full.
> 
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      | 1 -
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


