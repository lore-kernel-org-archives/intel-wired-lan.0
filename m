From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Sep 2017 21:44:39 +0000
Subject: [Intel-wired-lan] [RFC PATCH v3 3/6] i40e: Add infrastructure
 for queue channel support
In-Reply-To: <150478201697.24662.17031847488335081374.stgit@anamdev.jf.intel.com>
References: <150478158684.24662.17975701233699487888.stgit@anamdev.jf.intel.com>
 <150478201697.24662.17031847488335081374.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA2C6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Thursday, September 7, 2017 4:00 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [RFC PATCH v3 3/6] i40e: Add infrastructure for
> queue channel support
> 
> This patch sets up the infrastructure for offloading TCs and queue
> configurations to the hardware by creating HW channels(VSI).
> A new channel is created for each of the traffic class configuration offloaded
> via mqprio framework except for the first TC (TC0). TC0 for the main VSI is
> also reconfigured as per user provided queue parameters. Queue counts
> that are not power-of-2 are handled by reconfiguring RSS by reprogramming
> LUTs using the queue count value.
> This patch also handles configuring the TX rings for the channels, setting up
> the RX queue map for channel.
> 
> Also, the channels so created are removed and all the queue configuration is
> set to default when the qdisc is detached from the root of the device.
> 
> v3: Addressed Shannon's feedback removing unwanted code, variables,
> atomic operations (since setup_tc is protected with rtnl_lock held by stack)
> and other minor clean up.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |   32 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  718
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |    2
>  3 files changed, 743 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


