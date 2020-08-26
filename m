From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 26 Aug 2020 23:51:50 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] ice: Change ice_info_get_dsn to
 be void
In-Reply-To: <20200819215838.3834786-2-jacob.e.keller@intel.com>
References: <20200819215838.3834786-1-jacob.e.keller@intel.com>
 <20200819215838.3834786-2-jacob.e.keller@intel.com>
Message-ID: <DM6PR11MB28908DC52F1C9F72C7F2DDB5BC540@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jacob
> Keller
> Sent: Wednesday, August 19, 2020 2:59 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Subject: [Intel-wired-lan] [PATCH 1/3] ice: Change ice_info_get_dsn to be void
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> ice_info_get_dsn always returns 0, so just make it void.
> 
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
