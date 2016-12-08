From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Dec 2016 17:33:07 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix incorrect bitwise
 operations of PTP Rx timestamp flags
In-Reply-To: <0033F4D0CBA60E4088C47C946608755C02C8B736@BPXM22GP.gisp.nec.co.jp>
References: <0033F4D0CBA60E4088C47C946608755C02C8B736@BPXM22GP.gisp.nec.co.jp>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39AC1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yusuke Suzuki
> Sent: Sunday, November 20, 2016 10:49 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix incorrect bitwise operations of
> PTP Rx timestamp flags
> 
> From: Yusuke Suzuki <yus-suzuki@uf.jp.nec.com>
> 
> Rx timestamp does not work on 82599 and X540 because bitwise operation of
> RX_HWTSTAMP flags is incorrect and ixgbe_ptp_rx_hwtstamp() is never
> called. This patch fixes it to enable Rx timestamp on 82599 and X540.
> 
> Without this fix:
> # ptp4l -Hsmq -i ens27f0
> ptp4l[278.730]: selected /dev/ptp8 as PTP clock
> ptp4l[278.733]: port 1: INITIALIZING to LISTENING on INITIALIZE
> ptp4l[278.733]: port 0: INITIALIZING to LISTENING on INITIALIZE
> ptp4l[278.834]: port 1: received SYNC without timestamp
> ptp4l[278.835]: port 1: new foreign master 1c3947.fffe.60f9cc-1
> ptp4l[279.834]: port 1: received SYNC without timestamp
> ptp4l[280.834]: port 1: received SYNC without timestamp
> ptp4l[281.834]: port 1: received SYNC without timestamp
> ptp4l[282.834]: port 1: received SYNC without timestamp
> ptp4l[282.835]: selected best master clock 1c3947.fffe.60f9cc
> ptp4l[282.835]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
> ptp4l[283.834]: port 1: received SYNC without timestamp
> 
> With this fix:
> # ptp4l -Hsmq -i ens27f0
> ptp4l[239.154]: selected /dev/ptp8 as PTP clock
> ptp4l[239.157]: port 1: INITIALIZING to LISTENING on INITIALIZE
> ptp4l[239.157]: port 0: INITIALIZING to LISTENING on INITIALIZE
> ptp4l[240.989]: port 1: new foreign master 1c3947.fffe.60f9cc-1
> ptp4l[244.989]: selected best master clock 1c3947.fffe.60f9cc
> ptp4l[244.989]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
> ptp4l[246.977]: master offset -899583339542096 s0 freq      +0 path delay
> 16222
> ptp4l[247.977]: master offset -899583339617265 s1 freq  -75169 path delay
> 16177
> ptp4l[248.977]: master offset       -130 s2 freq  -75299 path delay     16177
> ptp4l[248.977]: port 1: UNCALIBRATED to SLAVE on
> MASTER_CLOCK_SELECTED
> ptp4l[249.977]: master offset         -9 s2 freq  -75217 path delay     16177
> ptp4l[250.977]: master offset         88 s2 freq  -75123 path delay     16132
> 
> Fixes: a9763f3cb54c ("ixgbe: Update PTP to support X550EM_x devices")
> Signed-off-by: Yusuke Suzuki <yus-suzuki@uf.jp.nec.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


