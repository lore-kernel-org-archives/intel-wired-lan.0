From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jan 2020 23:17:07 +0000
Subject: [Intel-wired-lan] [PATCH S37 03/15] ice: display supported and
 advertised link modes
In-Reply-To: <20200122152041.41498-3-anthony.l.nguyen@intel.com>
References: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
 <20200122152041.41498-3-anthony.l.nguyen@intel.com>
Message-ID: <0e9bfe8d77f24170b9470b51875badb8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 03/15] ice: display supported and
> advertised link modes
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Display all of the supported and advertised link modes based on the PHY
> capability with media.
> 
> Displaying all supported modes is more informative then only displaying the
> current link mode.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 282 +------------------
>  1 file changed, 2 insertions(+), 280 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


