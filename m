From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Dec 2019 01:25:52 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v3 2/5] igc: Add support
 for RX timestamping
In-Reply-To: <20191202231953.2203397-3-vinicius.gomes@intel.com>
References: <20191202231953.2203397-1-vinicius.gomes@intel.com>
 <20191202231953.2203397-3-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9719B446@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Monday, December 2, 2019 3:20 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue PATCH v3 2/5] igc: Add support for RX
> timestamping
> 
> This adds support for timestamping received packets.
> 
> It is based on the i210, as many features of i225 work the same way.
> The main difference from i210 is that i225 has support for choosing
> the timer register to use when timestamping packets. Right now, we
> only support using timer 0. The other difference is that i225 stores
> two timestamps in the receive descriptor, right now, we only retrieve
> one.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  17 ++
>  drivers/net/ethernet/intel/igc/igc_defines.h |  38 +++
>  drivers/net/ethernet/intel/igc/igc_main.c    |  10 +
>  drivers/net/ethernet/intel/igc/igc_ptp.c     | 272 +++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |   3 +
>  5 files changed, 340 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
