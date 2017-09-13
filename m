From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Sep 2017 21:46:21 +0000
Subject: [Intel-wired-lan] [RFC PATCH v3 6/6] i40e: Add support setting
 TC	max bandwidth rates
In-Reply-To: <150478203291.24662.3361290802097939640.stgit@anamdev.jf.intel.com>
References: <150478158684.24662.17975701233699487888.stgit@anamdev.jf.intel.com>
 <150478203291.24662.3361290802097939640.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA2F8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Thursday, September 7, 2017 4:01 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [RFC PATCH v3 6/6] i40e: Add support setting TC
> max bandwidth rates
> 
> This patch enables setting up maximum Tx rates for the traffic classes in i40e.
> The maximum rate is offloaded to the hardware through the mqprio
> framework by specifying the mode option as 'channel' and shaper option as
> 'bw_rlimit' and is configured for the VSI. Configuring minimum Tx rate limit is
> not supported in the device. The minimum usable value for Tx rate is
> 50Mbps.
> 
> Example:
> # tc qdisc add dev eth0 root mqprio num_tc 2  map 0 0 0 0 1 1 1 1\
>   queues 4 at 0 4 at 4 hw 1 mode channel shaper bw_rlimit\
>   max_rate 4Gbit 5Gbit
> 
> To dump the bandwidth rates:
> # tc qdisc show dev eth0
> 
> qdisc mqprio 804a: root  tc 2 map 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0
>              queues:(0:3) (4:7)
>              mode:channel
>              shaper:bw_rlimit   max_rate:4Gbit 5Gbit
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |    2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  101
> +++++++++++++++++++++++++--
>  2 files changed, 94 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


