From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:32:12 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 03/15] ice: display supported
 and advertised link modes
In-Reply-To: <20200206092013.23388-3-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
 <20200206092013.23388-3-anthony.l.nguyen@intel.com>
Message-ID: <8ef3dfd17fbc4144ae5bf68911e4039c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 v3 03/15] ice: display supported and
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


