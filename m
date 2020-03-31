From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 31 Mar 2020 20:57:11 +0000
Subject: [Intel-wired-lan] [PATCH 11/12] igc: Refactor
 igc_del_mac_filter()
In-Reply-To: <20200318230102.36952-12-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
 <20200318230102.36952-12-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722DF01@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, March 18, 2020 4:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 11/12] igc: Refactor igc_del_mac_filter()
> 
> This patch does a code refactoring in igc_del_mac_filter() so it uses
> the new helper igc_find_mac_filter() and improves the comment about the
> special handling when deleting the default filter.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 45 ++++++++++-------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
