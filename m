From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Apr 2020 23:44:09 +0000
Subject: [Intel-wired-lan] [PATCH 3/4] igc: Return -EOPNOTSUPP when VLAN
 mask doesn't match
In-Reply-To: <20200403181743.23447-4-andre.guedes@intel.com>
References: <20200403181743.23447-1-andre.guedes@intel.com>
 <20200403181743.23447-4-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28909D37A2EA5379269D9DD1BCD50@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 3, 2020 11:18 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/4] igc: Return -EOPNOTSUPP when VLAN
> mask doesn't match
> 
> The I225 controller supports rx queue assignment based on VLAN priority
> only. Other Tag Control Information (TCI) are valid, but not supported
> by the driver. So this patch changes the returning code from igc_add_
> ethtool_nfc_entry() to -EOPNOTSUPP in order to provide more meaningful
> information on why the function failed.
> 
> It also adds a debug messages to give the user a hint about what went
> wrong with the NFC setup.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
