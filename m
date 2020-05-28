From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:44:39 +0000
Subject: [Intel-wired-lan] [PATCH S45 14/15] ice: Increase timeout after
 PFR
In-Reply-To: <20200516005121.4963-14-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-14-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659F54A101AC3882F3CC2C38C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S45 14/15] ice: Increase timeout after PFR
> 
> From: Dan Nowlin <dan.nowlin@intel.com>
> 
> To allow for resets during package download, increase the timeout period
> after performing a PFR. The time waited is the global config lock timeout plus
> the normal PFSWR timeout.
> 
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


