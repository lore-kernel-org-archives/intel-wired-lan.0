From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 8 Apr 2021 21:31:55 +0000
Subject: [Intel-wired-lan] [PATCH S58 05/13] ice: Reimplement module
 reads used by ethtool
In-Reply-To: <20210331211708.55205-5-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
 <20210331211708.55205-5-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51052E4BAFE337C1D233845EFA749@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, March 31, 2021 2:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S58 05/13] ice: Reimplement module reads
> used by ethtool
> 
> From: Scott W Taylor <scott.w.taylor@intel.com>
> 
> There was an excessive increment of the QSFP page, which is now fixed.
> Additionally, this new update now reads 8 bytes at a time and will retry each
> request if the module/bus is busy.
> 
> Also, prevent reading from upper pages if module does not support those
> pages.
> 
> Signed-off-by: Scott W Taylor <scott.w.taylor@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 49 ++++++++++++++++----
>  1 file changed, 39 insertions(+), 10 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


