From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 31 Mar 2020 20:00:42 +0000
Subject: [Intel-wired-lan] [PATCH 05/12] igc: Refactor
 igc_rar_set_index()
In-Reply-To: <20200318230102.36952-6-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
 <20200318230102.36952-6-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722DDCC@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, March 18, 2020 4:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 05/12] igc: Refactor igc_rar_set_index()
> 
> Current igc_rar_set_index() implementation is a bit convoluted so this
> patch does some code refactoring to improve it.
> 
> The helper igc_rar_set_index() is about writing MAC filter settings into
> hardware registers. Logic such as address validation belongs to
> functions upper in the call chain such as igc_set_mac() and
> igc_add_mac_filter(). So this patch moves the is_valid_ether_addr() call
> to igc_add_mac_filter(). No need to touch igc_set_mac() since it already
> checks it.
> 
> The variables 'rar_low' and 'rar_high' represent the value in registers
> RAL and RAH so we rename them to 'ral' and 'rah', respectivelly, to
> match the registers names.
> 
> To make it explicity, filter settings are passed as arguments to the
> function instead of reading them from adapter->mac_table "under the
> hood". Also, the function was renamed to igc_set_mac_filter_hw to make
> it more clear what it does.
> 
> Finally, the patch removes some wrfl() calls and comments not needed.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 75 +++++++++++++----------
>  1 file changed, 43 insertions(+), 32 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
