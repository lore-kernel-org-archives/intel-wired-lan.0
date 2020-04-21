From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Apr 2020 23:40:38 +0000
Subject: [Intel-wired-lan] [PATCH 2/4] igc: Dump VLANPQF register
In-Reply-To: <20200403181743.23447-3-andre.guedes@intel.com>
References: <20200403181743.23447-1-andre.guedes@intel.com>
 <20200403181743.23447-3-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28902A376D933D11743A8B07BCD50@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 3, 2020 11:18 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/4] igc: Dump VLANPQF register
> 
> This patch adds the VLAN Priority Queue Filter Register (VLANPQF) to the
> list of registers dumped by igc_get_regs().
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
