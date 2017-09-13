From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Sep 2017 21:45:15 +0000
Subject: [Intel-wired-lan] [RFC PATCH v3 4/6] i40e: Enable 'channel'
 mode in mqprio for TC configs
In-Reply-To: <150478202229.24662.13170185123985209854.stgit@anamdev.jf.intel.com>
References: <150478158684.24662.17975701233699487888.stgit@anamdev.jf.intel.com>
 <150478202229.24662.13170185123985209854.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA2D7@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [RFC PATCH v3 4/6] i40e: Enable 'channel' mode in
> mqprio for TC configs
> 
> The i40e driver is modified to enable the new mqprio hardware offload mode
> and factor the TCs and queue configuration by creating channel VSIs. In this
> mode, the priority to traffic class mapping and the user specified queue
> ranges are used to configure the traffic classes by setting the mode option to
> 'channel'.
> 
> Example:
> # tc qdisc add dev eth0 root mqprio num_tc 4\
>   map 0 0 0 0 1 2 2 3 queues 2 at 0 2 at 2 1 at 4 1 at 5\
>   hw 1 mode channel
> 
> # tc qdisc show dev eth0
> 
> qdisc mqprio 8038: root  tc 4 map 0 0 0 0 1 2 2 3 0 0 0 0 0 0 0 0
>              queues:(0:1) (2:3) (4:4) (5:5)
>              mode:channel
>              shaper:dcb
> 
> The HW channels created are removed and all the queue configuration is set
> to default when the qdisc is detached from the root of the device.
> 
> # tc qdisc del dev eth0 root
> 
> This patch also disables setting up channels via ethtool (ethtool -L) when the
> TCs are configured using mqprio scheduler.
> 
> The patch also limits setting ethtool Rx flow hash indirection (ethtool -X eth0
> equal N) to max queues configured via mqprio.
> The Rx flow hash indirection input through ethtool should be validated so
> that it is within in the queue range configured via tc/mqprio. The bound
> checking is achieved by reporting the current rss size to the kernel when
> queues are configured via mqprio.
> 
> Example:
> # tc qdisc add dev eth0 root mqprio num_tc 4\
>   map 0 0 0 1 0 2 3 0 queues 2 at 0 4 at 2 8 at 6 11 at 14\
>   hw 1 mode channel
> 
> # ethtool -X eth0 equal 12
> Cannot set RX flow hash configuration: Invalid argument
> 
> v3: Changes to incorporate new mqprio mode option. Minor clean up of
> setup_tc error handling based on Shannon's comments.
> v2: Clean up __i40e_setup_tc() and i40e_setup_tc() to work with Jiri's
> changes to the ndo_setup_tc interface which now takes a type and the
> type_data for the offload.
> No need to disable ATR in MQPRIO mode.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |    3
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |    8
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  457
> ++++++++++++++++++------
>  3 files changed, 362 insertions(+), 106 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


