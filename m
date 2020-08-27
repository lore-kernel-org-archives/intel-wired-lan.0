From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 27 Aug 2020 01:32:04 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] ice: add the DDP Track ID to
 devlink info
In-Reply-To: <20200819215838.3834786-3-jacob.e.keller@intel.com>
References: <20200819215838.3834786-1-jacob.e.keller@intel.com>
 <20200819215838.3834786-3-jacob.e.keller@intel.com>
Message-ID: <DM6PR11MB28906C0A6983CBBEE57E7233BC550@DM6PR11MB2890.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH 2/3] ice: add the DDP Track ID to devlink info
> 
> Add "fw.app.bundle_id" to display the DDP Track ID of the active DDP
> package. This id is similar to "fw.bundle_id" and is a unique identifier
> for the DDP package that is loaded in the device. Each new DDP has
> a unique Track ID generated for it, and the ID can be used to identify
> and track the DDP package.
> 
> Add documentation for the new devlink info version.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  Documentation/networking/devlink/ice.rst     | 5 +++++
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 8 ++++++++
>  2 files changed, 13 insertions(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
