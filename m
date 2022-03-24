From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 24 Mar 2022 08:33:14 +0000
Subject: [Intel-wired-lan] [next-queue v2] i40e: Add support for MPLS +
 TSO
In-Reply-To: <1646270947-92954-1-git-send-email-jdamato@fastly.com>
References: <1646270947-92954-1-git-send-email-jdamato@fastly.com>
Message-ID: <BYAPR11MB3367A2FF3FE31B56602F16F6FC199@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Joe Damato <jdamato@fastly.com>
> Sent: Thursday, March 3, 2022 6:59 AM
> To: jdamato at fastly.com; Brandeburg, Jesse <jesse.brandeburg@intel.com>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; kuba at kernel.org; intel-wired-
> lan at lists.osuosl.org
> Cc: Mike Gallo <mgallo@fastly.com>
> Subject: [next-queue v2] i40e: Add support for MPLS + TSO
> 
> This change adds support for TSO of MPLS packets.
> 
> In my tests with tcpdump it seems to work. Note this test setup has a 9000
> byte MTU:
> 
> MPLS (label 100, exp 0, [S], ttl 64) IP srcip.50086 > dstip.1234:
>   Flags [P.], seq 593345:644401, ack 0, win 420,
>   options [nop,nop,TS val 45022534 ecr 1722291395], length 51056
> 
> IP dstip.1234 > srcip.50086: Flags [.], ack 593345, win 122,
>   options [nop,nop,TS val 1722291395 ecr 45022534], length 0
> 
> IP dstip.1234 > srcip.50086: Flags [.], ack 602289, win 105,
>   options [nop,nop,TS val 1722291395 ecr 45022534], length 0
> 
> IP dstip.1234 > srcip.50086: Flags [.], ack 620177, win 71,
>   options [nop,nop,TS val 1722291395 ecr 45022534], length 0
> 
> MPLS (label 100, exp 0, [S], ttl 64) IP srcip.50086 > dstip.1234:
>   Flags [P.], seq 644401:655953, ack 0, win 420,
>   options [nop,nop,TS val 45022534 ecr 1722291395], length 11552
> 
> IP dstip.1234 > srcip.50086: Flags [.], ack 638065, win 37,
>   options [nop,nop,TS val 1722291395 ecr 45022534], length 0
> 
> IP dstip.1234 > srcip.50086: Flags [.], ack 644401, win 25,
>   options [nop,nop,TS val 1722291395 ecr 45022534], length 0
> 
> IP dstip.1234 > srcip.50086: Flags [.], ack 653345, win 8,
>   options [nop,nop,TS val 1722291395 ecr 45022534], length 0
> 
> IP dstip.1234 > srcip.50086: Flags [.], ack 655953, win 3,
>   options [nop,nop,TS val 1722291395 ecr 45022534], length 0
> 
> v1 -> v2:
> 	- Restore erroneously deleted code from i40e_tso.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Co-developed-by: Mike Gallo <mgallo@fastly.com>
> Signed-off-by: Mike Gallo <mgallo@fastly.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 20 ++++++++++--
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 47 ++++++++++++++++++-----
> ------
>  2 files changed, 48 insertions(+), 19 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
