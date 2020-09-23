From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 23 Sep 2020 03:47:55 +0000
Subject: [Intel-wired-lan] [PATCH next-queue v1 1/2] igc: Export a way
 to read the PTP timer
In-Reply-To: <20200902233657.4051914-1-vinicius.gomes@intel.com>
References: <20200902233657.4051914-1-vinicius.gomes@intel.com>
Message-ID: <DM6PR11MB2890E75BC43AD05ABC49F4D0BC380@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Wednesday, September 2, 2020 4:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Guedes, Andre <andre.guedes@intel.com>
> Subject: [Intel-wired-lan] [PATCH next-queue v1 1/2] igc: Export a way to
> read the PTP timer
> 
> The next patch will need a way to retrieve the current timestamp from
> the NIC's PTP clock.
> 
> The 'i225' suffix is removed, if anything model specific is needed,
> those specifics should be hidden by this function.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h     | 1 +
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 7 +++----
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

