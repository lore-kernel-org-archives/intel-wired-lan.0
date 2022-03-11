From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 11 Mar 2022 06:33:03 +0000
Subject: [Intel-wired-lan] [PATCH] ice: add trace events for tx
 timestamps
In-Reply-To: <20220301230228.925588-1-jacob.e.keller@intel.com>
References: <20220301230228.925588-1-jacob.e.keller@intel.com>
Message-ID: <BYAPR11MB33677AD6BBA0027E4F039619FC0C9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, March 2, 2022 4:32 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Ken Young <keyoung@redhat.com>
> Subject: [Intel-wired-lan] [PATCH] ice: add trace events for tx timestamps
> 
> We've previously run into many issues related to the latency of a Tx
> timestamp completion with the ice hardware. It can be difficult to determine
> the root cause of a slow Tx timestamp. To aid in this, introduce new trace
> events which capture timing data about when the driver reaches certain
> points while processing a transmit timestamp
> 
>  * ice_tx_tstamp_request: Trace when the stack initiates a new timestamp
>    request.
> 
>  * ice_tx_tstamp_fw_req: Trace when the driver begins a read of the
>    timestamp register in the work thread.
> 
>  * ice_tx_tstamp_fw_done: Trace when the driver finishes reading a
>    timestamp register in the work thread.
> 
>  * ice_tx_tstamp_complete: Trace when the driver submits the skb back to
>    the stack with a completed Tx timestamp.
> 
> These trace events can be enabled using the standard trace event subsystem
> exposed by the ice driver. If they are disabled, they become no-ops with no
> run time cost.
> 
> The following is a simple GNU AWK script which can highlight one potential
> way to use the trace events to capture latency data from the trace buffer
> about how long the driver takes to process a timestamp:
> 
> -----
>   BEGIN {
>       PREC=256
>   }
> 
>   # Detect requests
>   /tx_tstamp_request/ {
>       time=strtonum($4)
>       skb=$7
> 
>       # Store the time of request for this skb
>       requests[skb] = time
>       printf("skb %s: idx %d at %.6f\n", skb, idx, time)
>   }
> 
>   # Detect completions
>   /tx_tstamp_complete/ {
>       time=strtonum($4)
>       skb=$7
>       idx=$9
> 
>       if (skb in requests) {
>           latency = (time - requests[skb]) * 1000
>           printf("skb %s: %.3f to complete\n", skb, latency)
>           if (latency > 4) {
>               printf(">>> HIGH LATENCY <<<\n")
>           }
>           printf("\n")
>       } else {
>           printf("!!! skb %s (idx %d) at %.6f\n", skb, idx, time)
>       }
>   }
> -----
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c   |  8 ++++++++
>  drivers/net/ethernet/intel/ice/ice_trace.h | 24 ++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 


Tested-by: Gurucharan  <gurucharanx.g@intel.com> (A Contingent worker at Intel)
