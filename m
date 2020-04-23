From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Apr 2020 21:35:58 +0000
Subject: [Intel-wired-lan] [PATCH v2 4/4] igc: Enable NFC rules based
 source MAC address
In-Reply-To: <20200413160049.35565-1-andre.guedes@intel.com>
References: <20200411002834.13916-5-andre.guedes@intel.com>
 <20200413160049.35565-1-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890DB4B7C3185E2F85EE279BCD30@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Monday, April 13, 2020 9:01 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 4/4] igc: Enable NFC rules based source
> MAC address
> 
> This patch adds support for Network Flow Classification (NFC) rules
> based on source MAC address. Note that the controller doesn't support
> rules with both source and destination addresses set, so this special
> case is checked in igc_add_ethtool_nfc_entry().
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
> v2: Fix memory leak when both dst and src are set.
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 32 ++++++++++++++------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
