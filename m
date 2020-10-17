From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 17 Oct 2020 03:43:47 +0000
Subject: [Intel-wired-lan] [PATCH net v1] igc: Fix returning wrong
 statistics
In-Reply-To: <20200925183537.2635645-1-vinicius.gomes@intel.com>
References: <20200925183537.2635645-1-vinicius.gomes@intel.com>
Message-ID: <DM6PR11MB28904BEA422EF7B19FEAEED7BC000@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Friday, September 25, 2020 11:36 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Guedes, Andre <andre.guedes@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] igc: Fix returning wrong statistics
> 
> 'igc_update_stats()' was not updating 'netdev->stats', so the returned
> statistics, for example, requested by:
> 
> $ ip -s link show dev enp3s0
> 
> were not being updated and were always zero.
> 
> Fix by returning a set of statistics that are actually being
> updated (adapter->stats64).
> 
> Fixes: c9a11c23ceb6 ("igc: Add netdev")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
