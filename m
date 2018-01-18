From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Jan 2018 19:01:08 +0000
Subject: [Intel-wired-lan] [PATCH v2 next-queue 07/12] i40evf: Add
 support to configure bw via tc tool
In-Reply-To: <20180117161607.49344-8-avinash.dayanand@intel.com>
References: <20180117161607.49344-1-avinash.dayanand@intel.com>
 <20180117161607.49344-8-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A935B8B@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 next-queue 07/12] i40evf: Add support
> to configure bw via tc tool
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> This patch adds support to configure bandwidth for the traffic classes via tc
> tool. The required information is passed to the PF which is used in the
> process of setting up the traffic classes.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 66
> +++++++++++++++++++++-
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  3 +
>  3 files changed, 67 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


