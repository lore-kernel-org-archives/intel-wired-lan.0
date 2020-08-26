From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 26 Aug 2020 22:02:01 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] igc: Fix wrong timestamp latency
 numbers
In-Reply-To: <20200817231231.2971207-1-vinicius.gomes@intel.com>
References: <20200817231231.2971207-1-vinicius.gomes@intel.com>
Message-ID: <DM6PR11MB2890E0EB7546D20AC94A87F3BC540@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Monday, August 17, 2020 4:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Guedes, Andre <andre.guedes@intel.com>
> Subject: [Intel-wired-lan] [PATCH 1/2] igc: Fix wrong timestamp latency numbers
> 
> The previous timestamping latency numbers were obtained by
> interpolating the i210 numbers with the i225 crystal clock value. That
> calculation was wrong.
> 
> Use the correct values from real measurements.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
