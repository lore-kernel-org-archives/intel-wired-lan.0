From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Dec 2019 01:26:17 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v3 3/5] igc: Add support
 for TX timestamping
In-Reply-To: <20191202231953.2203397-4-vinicius.gomes@intel.com>
References: <20191202231953.2203397-1-vinicius.gomes@intel.com>
 <20191202231953.2203397-4-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9719B45A@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Monday, December 2, 2019 3:20 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue PATCH v3 3/5] igc: Add support for TX
> timestamping
> 
> This adds support for timestamping packets being transmitted.
> 
> Based on the code from i210. The basic differences is that i225 has 4
> registers to store the transmit timestamps (i210 has one). Right now,
> we only support retrieving from one register, support for using the
> other registers will be added later.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  2 +
>  drivers/net/ethernet/intel/igc/igc_defines.h | 14 +++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 49 +++++++++++
>  drivers/net/ethernet/intel/igc/igc_ptp.c     | 92 ++++++++++++++++++++
>  4 files changed, 157 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
