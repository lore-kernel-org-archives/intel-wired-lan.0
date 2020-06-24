From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 24 Jun 2020 01:20:09 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove checking media
 type during MAC initialization
In-Reply-To: <20200617120131.21277-1-sasha.neftin@intel.com>
References: <20200617120131.21277-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB28905389236684F9FDF090F8BC950@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Wednesday, June 17, 2020 5:02 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove checking media type
> during MAC initialization
> 
> i225 device support only copper mode.
> There is no point to check media type in the
> igc_config_fc_after_link_up() method.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_mac.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
