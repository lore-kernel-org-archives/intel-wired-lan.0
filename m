From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Dec 2019 01:27:00 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v3 5/5] igc: Use Start of
 Packet signal from PHY for timestamping
In-Reply-To: <20191202231953.2203397-6-vinicius.gomes@intel.com>
References: <20191202231953.2203397-1-vinicius.gomes@intel.com>
 <20191202231953.2203397-6-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9719B482@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Monday, December 2, 2019 3:20 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue PATCH v3 5/5] igc: Use Start of Packet
> signal from PHY for timestamping
> 
> For better accuracy, i225 is able to do timestamping using the Start of
> Packet signal from the PHY.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 2 ++
>  drivers/net/ethernet/intel/igc/igc_ptp.c     | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
