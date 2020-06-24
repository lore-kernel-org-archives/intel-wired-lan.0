From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 24 Jun 2020 01:18:42 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Remove unneeded check for
 copper media type
In-Reply-To: <20200610124308.41422-1-sasha.neftin@intel.com>
References: <20200610124308.41422-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB2890658344D0295680935F05BC950@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Wednesday, June 10, 2020 5:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Remove unneeded check for
> copper media type
> 
> PHY of the i225 device support only copper mode.
> There is no point to check media type in the
> igc_power_up_link() method.
> 
> v1->v2:
> Address community comment and correct the title
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
