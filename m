From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Oct 2015 21:01:47 +0000
Subject: [Intel-wired-lan] [next PATCH S20 04/15] i40e/i40evf: prefetch
 skb	data on transmit
In-Reply-To: <1445903081-155893-5-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D482A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, October 26, 2015 4:45 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S20 04/15] i40e/i40evf: prefetch skb
> data on transmit
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Issue a prefetch for data early in the transmit path.
> This should not be generally needed for tx traffic, but it helps immensely for
> pktgen workloads and should help for forwarding workloads as well.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Iefee870c20599e0c4240e1d8637e4f16b625f83a
> 
> ---
> Testing-hints: Run transmit traffic UDP and TCP to make sure there is not a
> performance (CPU utilization) increase. Run pktgen (Jesse has helper script
> available) to see the performance increases with the patch when sending 64
> byte packets. For bonus points could test forwarding workload for
> performance improvement.
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 3 +++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 +++
>  2 files changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, performance increase seen with iperf3, and with pktgen script
