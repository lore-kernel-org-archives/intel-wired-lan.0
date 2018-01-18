From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Jan 2018 18:48:03 +0000
Subject: [Intel-wired-lan] [PATCH v2 next-queue 03/12] i40evf : add
 ndo_setup_tc callback to i40evf
In-Reply-To: <20180117161607.49344-4-avinash.dayanand@intel.com>
References: <20180117161607.49344-1-avinash.dayanand@intel.com>
 <20180117161607.49344-4-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A935B57@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Wednesday, January 17, 2018 8:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 next-queue 03/12] i40evf : add
> ndo_setup_tc callback to i40evf
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> This patch introduces the callback to the ndo_setup_tc function in the VF
> driver. We add a wrapper function to make room for the upcoming cloud
> filter patches which add calls to different functions from setup_tc.
> 
> First, we add support for capability exchange for ADQ between the PF and
> VF. Next, we add support to take in the mqprio configuration and configure
> queues as per the traffic classes, rate limit and the priorities specified by the
> user. This is done by passing the channel config to the PF driver through a
> virtchannel message.
> 
> The flags and bits added, track if ADq is enabled, set max number of traffic
> classes to 4 and provide ability to negotiate capability with the PF.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  22 +++
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 154
> +++++++++++++++++++++
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  82 ++++++++++-
>  3 files changed, 257 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


