From: Murali Karicheri <m-karicheri2@ti.com>
Date: Tue, 19 May 2020 10:53:42 -0400
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <20200516012948.3173993-1-vinicius.gomes@intel.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
Message-ID: <b33e582f-e0e6-467a-636a-674322108855@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vinicius,

On 5/15/20 9:29 PM, Vinicius Costa Gomes wrote:
> Hi,
> 
> This series adds support for configuring frame preemption, as defined
> by IEEE 802.1Q-2018 (previously IEEE 802.1Qbu) and IEEE 802.3br.
> 
> Frame preemption allows a packet from a higher priority queue marked
> as "express" to preempt a packet from lower priority queue marked as
> "preemptible". The idea is that this can help reduce the latency for
> higher priority traffic.
> 
> Previously, the proposed interface for configuring these features was
> using the qdisc layer. But as this is very hardware dependent and all
> that qdisc did was pass the information to the driver, it makes sense
> to have this in ethtool.
> 
> One example, for retrieving and setting the configuration:
> 
> $ ethtool $ sudo ./ethtool --show-frame-preemption enp3s0
> Frame preemption settings for enp3s0:
> 	support: supported
> 	active: active
> 	supported queues: 0xf

I assume this is will be in sync with ethtool -L output which indicates
how many tx h/w queues present? I mean if there are 8 h/w queues,
supported queues will show 0xff.

> 	supported queues: 0xe
 From the command below, it appears this is the preemptible queue mask.
bit 0  is Q0, bit 1 Q1 and so forth. Right? In that case isn't it more
clear to display
         preemptible queues : 0xef

In the above Q7 is express queue and Q6-Q0 are preemptible.

Also there is a handshake called verify that happens which initiated
by the h/w to check the capability of peer. It looks like
not all vendor's hardware supports it and good to have it displayed
something like

         Verify supported/{not supported}

If Verify is supported, FPE is enabled only if it succeeds. So may be
good to show a status of Verify if it is supported something like
         Verify success/Failed

> 	minimum fragment size: 68
> 
> 
> $ ethtool --set-frame-preemption enp3s0 fp on min-frag-size 68 preemptible-queues-mask 0xe
> 
> This is a RFC because I wanted to have feedback on some points:
> 
>    - The parameters added are enough for the hardware I have, is it
>      enough in general?

As described above, it would be good to add an optional parameter for
verify

ethtool --set-frame-preemption enp3s0 fp on min-frag-size 68 
preemptible-queues-mask 0xe verify on

> 
>    - even with the ethtool via netlink effort, I chose to keep the
>      ioctl() way, in case someone wants to backport this to an older
>      kernel, is there a problem with this?
> 
>    - Some space for bikeshedding the names and location (for example,
>      does it make sense for these settings to be per-queue?), as I am
>      not quite happy with them, one example, is the use of preemptible
>      vs. preemptable;
> 
> 
> About the patches, should be quite straightforward:
> 
> Patch 1, adds the ETHTOOL_GFP and ETHOOL_SFP commands and the
> associated data structures;
> 
> Patch 2, adds the ETHTOOL_MSG_PREEMPT_GET and ETHTOOL_MSG_PREEMPT_SET
> netlink messages and the associated attributes;
> 
> Patch 3, is the example implementation for the igc driver, the catch
> here is that frame preemption in igc is dependent on the TSN "mode"
> being enabled;
> 
> Patch 4, adds some registers that helped during implementation.
> 
> Another thing is that because igc is still under development, to avoid
> conflicts, I think it might be easier for the PATCH version of this
> series to go through Jeff Kirsher's tree.
> 
> Vinicius Costa Gomes (4):
>    ethtool: Add support for configuring frame preemption
>    ethtool: Add support for configuring frame preemption via netlink
>    igc: Add support for configuring frame preemption
>    igc: Add support for exposing frame preemption stats registers
> 
>   drivers/net/ethernet/intel/igc/igc.h         |   3 +
>   drivers/net/ethernet/intel/igc/igc_defines.h |   6 +
>   drivers/net/ethernet/intel/igc/igc_ethtool.c |  77 ++++++++
>   drivers/net/ethernet/intel/igc/igc_regs.h    |  10 +
>   drivers/net/ethernet/intel/igc/igc_tsn.c     |  46 ++++-
>   include/linux/ethtool.h                      |   6 +
>   include/uapi/linux/ethtool.h                 |  25 +++
>   include/uapi/linux/ethtool_netlink.h         |  19 ++
>   net/ethtool/Makefile                         |   3 +-
>   net/ethtool/ioctl.c                          |  36 ++++
>   net/ethtool/netlink.c                        |  15 ++
>   net/ethtool/netlink.h                        |   2 +
>   net/ethtool/preempt.c                        | 181 +++++++++++++++++++
>   13 files changed, 423 insertions(+), 6 deletions(-)
>   create mode 100644 net/ethtool/preempt.c
> 

-- 
Murali Karicheri
Texas Instruments
