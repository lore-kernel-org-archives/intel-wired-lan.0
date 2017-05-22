From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 22 May 2017 12:31:12 -0700
Subject: [Intel-wired-lan] [PATCH 0/4] Configuring traffic classes via
 new hardware offload mechanism in tc/mqprio
In-Reply-To: <149524122523.11022.4541073724650541658.stgit@anamdev.jf.intel.com>
References: <149524122523.11022.4541073724650541658.stgit@anamdev.jf.intel.com>
Message-ID: <1495481472.4878.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2017-05-19 at 17:58 -0700, Amritha Nambiar wrote:
> The following series introduces a new harware offload mode in tc/mqprio
> where the TCs, the queue configurations and bandwidth rate limits are
> offloaded to the hardware.
> The i40e driver enables the new mqprio hardware offload mechanism
> factoring the TCs, queue configuration and bandwidth rates by creating HW
> channel VSIs.?
> 
> In this mode, the priority to traffic class mapping and the user
> specified queue ranges are used to configure the traffic class when the
> 'hw' option is set to 2. This is achieved by creating HW channels(VSI). A
> new channel is created for each of the traffic class configuration
> offloaded via mqprio framework except for the first TC (TC0) which is for
> the main VSI. TC0 for the main VSI is also reconfigured as per user
> provided queue parameters. Finally, bandwidth rate limits are set on
> these traffic classes through the mqprio offload framework by sending
> these rates in addition to the number of TCs and the queue
> configurations.
> 
> Example:
> # tc qdisc add dev eth0 root mqprio num_tc 2??map 0 0 0 0 1 1 1 1\
> ? queues 4 at 0 4 at 4 min_rate 0Mbit 0Mbit max_rate 55Mbit 60Mbit hw 2
> 
> To dump the bandwidth rates:
> 
> # tc qdisc show dev eth0
> ? qdisc mqprio 804a: root??tc 2 map 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0
> ???????????????queues:(0:3) (4:7)
> ???????????????min rates:0bit 0bit
> ???????????????max rates:55Mbit 60Mbit
> 

This was meant to be sent out as an RFC, but apparently that did not get
conveyed when these were sent out Friday.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170522/d42362ce/attachment.asc>
