From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 23:21:34 +0000
Subject: [Intel-wired-lan] [PATCH S46 9/9] ice: Ignore EMODE when
 setting PHY config
In-Reply-To: <20200516005506.5113-9-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
 <20200516005506.5113-9-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16596AE2138C4D207D4C47398C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S46 9/9] ice: Ignore EMODE when setting
> PHY config
> 
> From: Chinh T Cao <chinh.t.cao@intel.com>
> 
> When setting the PHY cfg (CQ cmd 0x0601), if the firmware responds with an
> EMODE error, software will ignore the error as it simply means that
> manageability (ex: BMC) is in control of the link and that the new setting may
> not be applied.
> 
> Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1 +
>  drivers/net/ethernet/intel/ice/ice_common.c     | 7 ++++++-
>  drivers/net/ethernet/intel/ice/ice_main.c       | 2 ++
>  3 files changed, 9 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


