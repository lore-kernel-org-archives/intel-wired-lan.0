From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 12 Oct 2020 20:53:40 +0000
Subject: [Intel-wired-lan] [PATCH S53 12/15] ice: cleanup misleading
 comment
In-Reply-To: <20200917201347.81570-12-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
 <20200917201347.81570-12-anthony.l.nguyen@intel.com>
Message-ID: <DM6PR11MB28908C36FEFAC998517653A3BC070@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, September 17, 2020 1:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S53 12/15] ice: cleanup misleading
> comment
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> The maximum Admin Queue buffer size and NVM shadow RAM sector size
> are both
> 4 Kilobytes. Some comments refer to those as 4Kb which can be confused
> with
> 4 Kilobits. Update the comments to use the commonly used KB symbol
> instead.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_nvm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
