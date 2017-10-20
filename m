From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 20 Oct 2017 01:47:02 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v9 6/6] igb: Add support
 for	CBS offload
In-Reply-To: <20171017010128.22141-7-vinicius.gomes@intel.com>
References: <20171017010128.22141-1-vinicius.gomes@intel.com>
 <20171017010128.22141-7-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6C507C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Vinicius Costa Gomes
> Sent: Monday, October 16, 2017 6:01 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Cc: rodney.cummings at ni.com; Guedes, Andre <andre.guedes@intel.com>;
> jiri at resnulli.us; Briano, Ivan <ivan.briano@intel.com>;
> richardcochran at gmail.com; henrik at austad.us; jhs at mojatatu.com;
> levipearson at gmail.com; Ong, Boon Leong <boon.leong.ong@intel.com>;
> xiyou.wangcong at gmail.com; Sanchez-Palencia, Jesus <jesus.sanchez-
> palencia at intel.com>
> Subject: [Intel-wired-lan] [next-queue PATCH v9 6/6] igb: Add support for
> CBS offload
> 
> From: Andre Guedes <andre.guedes@intel.com>
> 
> This patch adds support for Credit-Based Shaper (CBS) qdisc offload
> from Traffic Control system. This support enable us to leverage the
> Forwarding and Queuing for Time-Sensitive Streams (FQTSS) features
> from Intel i210 Ethernet Controller. FQTSS is the former 802.1Qav
> standard which was merged into 802.1Q in 2014. It enables traffic
> prioritization and bandwidth reservation via the Credit-Based Shaper
> which is implemented in hardware by i210 controller.
> 
> The patch introduces the igb_setup_tc() function which implements the
> support for CBS qdisc hardware offload in the IGB driver. CBS offload
> is the only traffic control offload supported by the driver at the
> moment.
> 
> FQTSS transmission mode from i210 controller is automatically enabled
> by the IGB driver when the CBS is enabled for the first hardware
> queue. Likewise, FQTSS mode is automatically disabled when CBS is
> disabled for the last hardware queue. Changing FQTSS mode requires NIC
> reset.
> 
> FQTSS feature is supported by i210 controller only.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_defines.h |  23 ++
>  drivers/net/ethernet/intel/igb/e1000_regs.h    |   8 +
>  drivers/net/ethernet/intel/igb/igb.h           |   6 +
>  drivers/net/ethernet/intel/igb/igb_main.c      | 347
> +++++++++++++++++++++++++
>  4 files changed, 384 insertions(+)

From a regression standpoint:
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
