From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 23 Jun 2021 20:15:58 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix missing rtnl locking
 when setting up pf switch
In-Reply-To: <20210611100141.6089-1-mateusz.palczewski@intel.com>
References: <20210611100141.6089-1-mateusz.palczewski@intel.com>
Message-ID: <SJ0PR11MB56626CCB05BC3E0852356C4AFA089@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Friday, June 11, 2021 3:02 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix missing rtnl locking when
> setting up pf switch
> 
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> A recent change that made i40e use new udp_tunnel infrastructure uses a
> method that expects to be called under rtnl lock.
> 
> However, not all codepaths do the lock prior to calling i40e_setup_pf_switch.
> 
> Fix that by adding additional rtnl locking and unlocking.
> 
> Fixes: 40a98cb6f01f ("i40e: convert to new udp_tunnel infrastructure")
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


