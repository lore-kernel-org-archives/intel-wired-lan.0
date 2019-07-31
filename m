From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:10:09 +0000
Subject: [Intel-wired-lan] [PATCH S24 v2 05/12] ice: Fix RSS LUT table
 when setting Rx channels
In-Reply-To: <20190729090454.5501-5-anthony.l.nguyen@intel.com>
References: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
 <20190729090454.5501-5-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E88D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, July 29, 2019 2:05 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S24 v2 05/12] ice: Fix RSS LUT table when
> setting Rx channels
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently there are multiple problems involved with setting Rx channels in
> regards to the RSS LUT. First, if the user set the indirection table manually
> through ethtool, changing the Rx channels will blindly use the user set value.
> Second when increasing the number of Rx channels the RSS table size is
> doing of minimum of the last RSS table width and the newly requested one,
> this is causing the previously set RSS table width to be used.
> 
> Fix these issues by adding the function ice_pf_set_dflt_rss_lut() that is called
> when changing the number of Rx channels. This function updates the RSS
> LUT to the default configuration for the PF any time the user has changed the
> number of Rx channels.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2: Change function to take VSI instead of PF
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 63 ++++++++++++++++++++
>  1 file changed, 63 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


