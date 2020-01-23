From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:11:29 +0000
Subject: [Intel-wired-lan] [PATCH S36 6/8] ice: Initilialize VF RSS
 tables
In-Reply-To: <20200117153919.50321-6-anthony.l.nguyen@intel.com>
References: <20200117153919.50321-1-anthony.l.nguyen@intel.com>
 <20200117153919.50321-6-anthony.l.nguyen@intel.com>
Message-ID: <cafb92d8a7ca4ba295dcfa488bb26501@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S36 6/8] ice: Initilialize VF RSS tables
> 
> From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> 
> Set configuration for hardware RSS tables for VFs.
> 
> Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 135 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.h     |  59 ++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  31 +++-
>  .../ethernet/intel/ice/ice_protocol_type.h    |   1 +
>  4 files changed, 225 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


