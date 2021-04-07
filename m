From: Switzer, David <david.switzer@intel.com>
Date: Wed, 7 Apr 2021 22:55:42 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix sparse error:
 'vsi->netdev' could be null
In-Reply-To: <20210326184343.133396-3-arkadiusz.kubalewski@intel.com>
References: <20210326184343.133396-1-arkadiusz.kubalewski@intel.com>
 <20210326184343.133396-3-arkadiusz.kubalewski@intel.com>
Message-ID: <MW3PR11MB4748BCD0B7C9E4EBEE767F74EB759@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Arkadiusz Kubalewski
>Sent: Friday, March 26, 2021 11:44 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
>Subject: [Intel-wired-lan] [PATCH net] i40e: Fix sparse error: 'vsi->netdev' could
>be null
>
>Remove vsi->netdev->name from the trace.
>This is redundant information. With the devinfo trace, the adapter is already
>identifiable.
>
>Previously following error was produced when compiling against sparse.
>i40e_main.c:2571 i40e_sync_vsi_filters() error:
>	we previously assumed 'vsi->netdev' could be null (see line 2323)
>
>Fixes: b603f9dc20af ("i40e: Log info when PF is entering and leaving Allmulti
>mode.")
>Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
 

