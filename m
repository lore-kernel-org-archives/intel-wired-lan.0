From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 5 Aug 2020 19:58:11 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix MAC address setting for a
 VF via Host/VM
In-Reply-To: <20200804105550.10763-1-arkadiusz.kubalewski@intel.com>
References: <20200804105550.10763-1-arkadiusz.kubalewski@intel.com>
Message-ID: <BN6PR1101MB2145FCC62AE16E6921C73A7D8C4B0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Arkadiusz Kubalewski
> Sent: Tuesday, August 4, 2020 3:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix MAC address setting for a VF via
> Host/VM
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> Fix MAC setting flow for the PF driver.
> 
> Without this change the MAC address setting was interpreted incorrectly in
> the following usecases:
> 1) Print incorrect VF MAC or zero MAC
> ip link show dev $pf
> 2) Don't preserve MAC between driver reload rmmod iavf; modprobe iavf
> 3) Update VF MAC when macvlan was set
> ip link add link $vf address $mac $vf.1 type macvlan
> 4) Failed to update mac address when VF was trusted ip link set dev $vf
> address $mac
> 
> This includes all other configurations including above commands.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 25 +++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


