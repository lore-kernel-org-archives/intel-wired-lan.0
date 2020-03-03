From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:06:07 +0000
Subject: [Intel-wired-lan] [PATCH S40 06/15] ice: Display Link detected
 via Ethtool in safe mode
In-Reply-To: <20200227181505.61720-6-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-6-anthony.l.nguyen@intel.com>
Message-ID: <2b93ccfe37e34c6ea3bb4ffd102c1908@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 06/15] ice: Display Link detected via
> Ethtool in safe mode
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the "Link detected" field is not shown when the device goes into
> safe mode. This is because the safe mode Ethtool ops does not set the
> get_link function. Fix this by setting the safe mode Ethtool op get_link
> function.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


