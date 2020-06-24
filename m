From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 24 Jun 2020 01:17:05 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Refactor the
 igc_power_down_link()
In-Reply-To: <20200608154939.30699-1-sasha.neftin@intel.com>
References: <20200608154939.30699-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB2890A0D6261A89047CD6A303BC950@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Monday, June 8, 2020 8:50 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Refactor the
> igc_power_down_link()
> 
> Currently inplementation of the igc_power_down_link()
> method a bit tangled. This method just called
> igc_power_down_phy_copper-base() method.
> We can just call the igc_power_down_phy_copper_base()
> method directly.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
