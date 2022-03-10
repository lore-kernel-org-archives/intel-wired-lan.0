From: Sreenivas, Bharathi <bharathi.sreenivas@intel.com>
Date: Thu, 10 Mar 2022 18:09:23 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4 1/2] devlink: Allow
 parameter registration/unregistration during runtime
In-Reply-To: <BN9PR11MB549766F269D3EA6D0F0D8338E40B9@BN9PR11MB5497.namprd11.prod.outlook.com>
References: <20220310103959.369773-1-sudheer.mogilappagari@intel.com>
 <20220310103959.369773-2-sudheer.mogilappagari@intel.com>
 <BN9PR11MB549766F269D3EA6D0F0D8338E40B9@BN9PR11MB5497.namprd11.prod.outlook.com>
Message-ID: <MN2PR11MB36147AA4918EB619872D92C58E0B9@MN2PR11MB3614.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sudheer Mogilappagari
> Sent: Thursday, March 10, 2022 2:40 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v4 1/2] devlink: Allow parameter
> registration/unregistration during runtime
> 
> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> commit 7a690ad499e7 ("devlink: Clean not-executed param notifications")
> added ASSERTs and removed notifications when devlink parameters are
> registered by the drivers after the associated devlink instance is already
> registered.
> The next patch in this series adds a feature in 'ice' driver that is only enabled
> when ADQ queue groups are created and introduces a devlink parameter to
> configure this feature per queue group.
> 
> To allow dynamic parameter registration/unregistration during runtime,
> revert the changes added by the above commit.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  net/core/devlink.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
