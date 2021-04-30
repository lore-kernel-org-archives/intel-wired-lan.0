From: Hassan Reza Biswas, Imam <imam.hassan.reza.biswas@intel.com>
Date: Fri, 30 Apr 2021 12:29:56 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Remove lldp frame filters
In-Reply-To: <20210416214357.341975-1-arkadiusz.kubalewski@intel.com>
References: <20210416214357.341975-1-arkadiusz.kubalewski@intel.com>
Message-ID: <MWHPR11MB1312774CA08BBABCA0C7978DFE5E9@MWHPR11MB1312.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Kubalewski, Arkadiusz
> Sent: Saturday, April 17, 2021 3:14 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net] i40e: Remove lldp frame filters
> 
> Remove filters from being setup in case of software DCB and allow the lldp
> frames to be properly transmitted to the wire.
> 
> It is not possible to transmit the LLDP frame out of the port, if they are
> filtered by control VSI. This prohibits software lldp agent properly
> communicate it's DCB capabilities to the neighbors.
> 
> Fixes: 4b208eaa8078 ("i40e: Add init and default config of software based
> DCB")
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  1 -
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 42 -------------------
>  3 files changed, 44 deletions(-)
> 
Tested-by: Imam Hassan Reza Biswas (imam.hassan.reza.biswas at intel.com)
