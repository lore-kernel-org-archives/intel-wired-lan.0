From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:57:54 +0000
Subject: [Intel-wired-lan] [PATCH 17/19] igc: Change return type from
 igc_disable_nfc_rule()
In-Reply-To: <20200424201623.10971-18-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-18-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890464446F56FD2ACE70FB3BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 17/19] igc: Change return type from
> igc_disable_nfc_rule()
> 
> None of igc_disable_nfc_rule() callers actually check its returning
> value. A closer look at why this function would fail shows that the
> only situation is when we try to delete an ethertype or mac filter that
> doesn't exist.
> 
> That situation is very unlikely so we can change igc_del_etype_filter()
> and igc_del_mac_filter() logic to "if the filter doesn't exist, we are
> done", and keep the logic in igc_disable_nfc_rule() callers simple.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 26 ++++++++---------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
