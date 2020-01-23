From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:10:37 +0000
Subject: [Intel-wired-lan] [PATCH S36 4/8] ice: Enable writing filtering
 tables
In-Reply-To: <20200117153919.50321-4-anthony.l.nguyen@intel.com>
References: <20200117153919.50321-1-anthony.l.nguyen@intel.com>
 <20200117153919.50321-4-anthony.l.nguyen@intel.com>
Message-ID: <6d78d815620e4428879133dae8e30cc5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, January 17, 2020 7:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S36 4/8] ice: Enable writing filtering tables
> 
> Write the hardware tables based on the populated software structures.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 604 ++++++++++++++++++
>  .../net/ethernet/intel/ice/ice_flex_type.h    |  46 ++
>  3 files changed, 651 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


