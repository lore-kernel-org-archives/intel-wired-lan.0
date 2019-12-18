From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:20:26 +0000
Subject: [Intel-wired-lan] [PATCH S35 06/15] ice: Restore interrupt
 throttle settings after VSI rebuild
In-Reply-To: <20191212111307.33566-6-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-6-anthony.l.nguyen@intel.com>
Message-ID: <2382a5ab41a94cc5898f418d06ebbcb2@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S35 06/15] ice: Restore interrupt throttle
> settings after VSI rebuild
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> After each rebuild driver deallocates q_vectors, so the interrupt throttle rate
> (ITR) settings get lost.
> 
> Create a function to save and restore ITR for each queue. If a user increases
> the number of queues, restore all the previous queue settings for each
> existing queue, and the additional queues will get the default setting.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 102 ++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.h |   6 ++
>  2 files changed, 108 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


