From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 May 2018 18:15:11 +0000
Subject: [Intel-wired-lan] [next PATCH S91 08/11] i40evf: remove
 MAX_QUEUES and just use I40EVF_MAX_REQ_QUEUES
In-Reply-To: <20180510125949.79823-8-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
 <20180510125949.79823-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B765119@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, May 10, 2018 6:00 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S91 08/11] i40evf: remove
> MAX_QUEUES and just use I40EVF_MAX_REQ_QUEUES
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We don't really need to have separate definitions for MAX_QUEUES and
> I40EVF_MAX_REQ_QUEUES, since we'll always be limited by how many
> queues we request anyways. If we haven't enabled requesting the
> maximum number of queues, there's no reason to have our call to
> alloc_etherdev_mq actually pass the higher value, since we'd never enable
> those queues anyways.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h      | 1 -
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 5 +++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


