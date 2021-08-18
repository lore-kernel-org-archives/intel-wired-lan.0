From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 19 Aug 2021 00:11:24 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v3 3/3] igc: Add support
 for CBS offloading
In-Reply-To: <1628520820-28907-4-git-send-email-aravindhan.gunasekaran@intel.com>
References: <1628520820-28907-1-git-send-email-aravindhan.gunasekaran@intel.com>
 <1628520820-28907-4-git-send-email-aravindhan.gunasekaran@intel.com>
Message-ID: <101a69fe-25e7-f33c-01f5-40294332c586@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/9/2021 17:53, aravindhan.gunasekaran at intel.com wrote:
> From: Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>
> 
> Implemented support for Credit-based shaper(CBS) Qdisc hardware
> offload mode in the driver. There are two sets of IEEE802.1Qav
> (CBS) HW logic in i225 controller and this patch supports
> enabling them in the top two priority TX queues.
> 
> Driver implemented as recommended by Foxville External
> Architecture Specification v0.993. Idleslope and Hi-credit are
> the CBS tunable parameters for i225 NIC, programmed in TQAVCC
> and TQAVHC registers respectively.
> 
> In-order for IEEE802.1Qav (CBS) algorithm to work as intended
> and provide BW reservation CBS should be enabled in highest
> priority queue first. If we enable CBS on any of low priority
> queues, the traffic in high priority queue does not allow low
> priority queue to be selected for transmission and bandwidth
> reservation is not guaranteed.
> 
> Signed-off-by: Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>
> Signed-off-by: Mallikarjuna Chilakala <mallikarjuna.chilakala@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         |  11 ++-
>   drivers/net/ethernet/intel/igc/igc_defines.h |   8 +++
>   drivers/net/ethernet/intel/igc/igc_main.c    |  71 ++++++++++++++++++
>   drivers/net/ethernet/intel/igc/igc_regs.h    |   3 +
>   drivers/net/ethernet/intel/igc/igc_tsn.c     | 103 +++++++++++++++++++++++++++
>   5 files changed, 195 insertions(+), 1 deletion(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
