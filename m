From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 23 Sep 2020 03:51:23 +0000
Subject: [Intel-wired-lan] [PATCH next-queue v1 2/2] igc: Reject
 schedules with a base_time in the future
In-Reply-To: <20200902233657.4051914-2-vinicius.gomes@intel.com>
References: <20200902233657.4051914-1-vinicius.gomes@intel.com>
 <20200902233657.4051914-2-vinicius.gomes@intel.com>
Message-ID: <DM6PR11MB28905F5373F4CBD48E6C36A7BC380@DM6PR11MB2890.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH next-queue v1 2/2] igc: Reject schedules
> with a base_time in the future
> 
> When we set the BASET registers of i225 with a base_time in the
> future, i225 will "hold" all packets until that base_time is reached,
> causing a lot of TX Hangs.
> 
> As this behaviour seems contrary to the expectations of the IEEE
> 802.1Q standard (section 8.6.9, specially 8.6.9.4.5), let's start by
> rejecting these types of schedules. If this is too limiting, we can
> for example, setup a timer to configure the BASET registers closer to
> the start time, only blocking the packets for a "short" while.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 25 +++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

