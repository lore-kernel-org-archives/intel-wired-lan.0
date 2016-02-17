From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 17 Feb 2016 23:21:44 +0000
Subject: [Intel-wired-lan] [next PATCH 1/4] i40e/i40evf: Break up
 xmit_descriptor_count from maybe_stop_tx
In-Reply-To: <20160217190243.10339.65965.stgit@localhost.localdomain>
References: <20160217185838.10339.68543.stgit@localhost.localdomain>
 <20160217190243.10339.65965.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F081@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, February 17, 2016 11:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 1/4] i40e/i40evf: Break up
> xmit_descriptor_count from maybe_stop_tx
> 
> In an upcoming patch I would like to have access to the descriptor count used
> for the data portion of the frame.  For this reason I am splitting up the
> descriptor count function from the function that stops the ring.
> 
> Also in order to try and reduce unnecessary duplication of code I am moving
> the slow-path portions of the code out of being inline calls so that we can just
> jump to them and process them instead of having to build them into each
> function that calls them.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c   |   14 ++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   71 +++++--------------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   44 +++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   64 +++++------------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |   42 +++++++++++++++
>  5 files changed, 123 insertions(+), 112 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
