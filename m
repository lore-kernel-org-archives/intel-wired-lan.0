From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:09:12 +0000
Subject: [Intel-wired-lan] [PATCH S27 06/15] ice: Remove enable DCB when
 SW LLDP is activated
In-Reply-To: <20190808143938.4968-6-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
 <20190808143938.4968-6-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D411631@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 06/15] ice: Remove enable DCB when
> SW LLDP is activated
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> Remove code that enables DCB in initialization when SW LLDP is activated.
> DCB flag is set or reset before in ice_init_pf_dcb based on number of TCs. So
> there is not need to overwrite it.
> 
> Setting DCB without checking number of TCs can cause communication
> problems with other cards. Host card sends packet with VLAN priority tag,
> but client card doesn't strip this tag and ping doesn't work.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


