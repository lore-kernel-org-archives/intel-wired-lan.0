From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 31 Mar 2020 20:56:51 +0000
Subject: [Intel-wired-lan] [PATCH 10/12] igc: Refactor
 igc_mac_entry_can_be_used()
In-Reply-To: <20200318230102.36952-11-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
 <20200318230102.36952-11-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722DEED@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, March 18, 2020 4:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 10/12] igc: Refactor
> igc_mac_entry_can_be_used()
> 
> The helper igc_mac_entry_can_be_used() implementation is a bit
> convoluted since it does two different things: find a not-in-use slot
> in mac_table or find an in-use slot where the address and address type
> match. This patch does a code refactoring and break it up into two
> helper functions.
> 
> With this patch we might traverse mac_table twice in some situations,
> but this is not harmful performance-wise (mac_table has only 16 entries
> and adding mac filters is not hot-path), and it improves igc_add_mac_
> filter() readability considerably.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 80 +++++++++++++----------
>  1 file changed, 47 insertions(+), 33 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
