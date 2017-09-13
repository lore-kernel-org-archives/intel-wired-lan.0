From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Sep 2017 21:43:31 +0000
Subject: [Intel-wired-lan] [RFC PATCH v3 1/6] mqprio: Introduce new
 hardware offload mode and shaper in mqprio
In-Reply-To: <150478200636.24662.17572491925361676670.stgit@anamdev.jf.intel.com>
References: <150478158684.24662.17975701233699487888.stgit@anamdev.jf.intel.com>
 <150478200636.24662.17572491925361676670.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA2A7@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [RFC PATCH v3 1/6] mqprio: Introduce new
> hardware offload mode and shaper in mqprio
> 
> The offload types currently supported in mqprio are 0 (no offload) and
> 1 (offload only TCs) by setting these values for the 'hw' option. If offloads are
> supported by setting the 'hw' option to 1, the default offload mode is 'dcb'
> where only the TC values are offloaded to the device. This patch introduces a
> new hardware offload mode called 'channel' with 'hw' set to 1 in mqprio
> which makes full use of the mqprio options, the TCs, the queue
> configurations and the QoS parameters for the TCs. This is achieved through
> a new netlink attribute for the 'mode' option which takes values such as 'dcb'
> (default) and 'channel'.
> The 'channel' mode also supports QoS attributes for traffic class such as
> minimum and maximum values for bandwidth rate limits.
> 
> This patch enables configuring additional HW shaper attributes associated
> with a traffic class. Currently the shaper for bandwidth rate limiting is
> supported which takes options such as minimum and maximum bandwidth
> rates and are offloaded to the hardware in the 'channel' mode. The min and
> max limits for bandwidth rates are provided by the user along with the the
> TCs and the queue configurations when creating the mqprio qdisc. The
> interface can be extended to support new HW shapers in future through the
> 'shaper'
> attribute.
> 
> Introduces a new datastructure 'tc_mqprio_qopt_offload' for offloading
> mqprio queue options and use this to be shared between the kernel and
> device driver. This contains a copy of the exisiting datastructure for mqprio
> queue options. This new datastructure can be extended when adding new
> attributes for traffic class such as mode, shaper, shaper parameters
> (bandwidth rate limits). The existing datastructure for mqprio queue options
> will be shared between the kernel and userspace.
> 
> Example:
> # tc qdisc add dev eth0 root mqprio num_tc 2 map 0 0 0 0 1 1 1 1\
>   queues 4 at 0 4 at 4 hw 1 mode channel shaper bw_rlimit\
>   min_rate 1Gbit 2Gbit max_rate 4Gbit 5Gbit
> 
> To dump the bandwidth rates:
> 
> # tc qdisc show dev eth0
> 
> qdisc mqprio 804a: root  tc 2 map 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0
>              queues:(0:3) (4:7)
>              mode:channel
>              shaper:bw_rlimit   min_rate:1Gbit 2Gbit   max_rate:4Gbit 5Gbit
> 
> v3 : Removed supporting new offloads through value 2 for 'hw' option,
> introduced new netlink based options for offload mode and HW shaper.
> v2 : Jiri's changes accepted upstream removes the struct tc_to_netdev. Clean
> up the full offload related changes added to
> mqprio_init() and mqprio_destroy() to rebase on these changes.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  include/net/pkt_cls.h          |    9 ++
>  include/uapi/linux/pkt_sched.h |   32 +++++++
>  net/sched/sch_mqprio.c         |  183
> ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 215 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


