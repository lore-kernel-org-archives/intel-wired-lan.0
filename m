From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 24 Nov 2021 12:18:05 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix NULL pointer
 dereference in i40e_dbg_dump_desc
In-Reply-To: <20211122112905.30552-1-mateusz.palczewski@intel.com>
References: <20211122112905.30552-1-mateusz.palczewski@intel.com>
Message-ID: <BYAPR11MB33672C923A28FD009A98A4ECFC619@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Monday, November 22, 2021 4:59 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Dziedziuch, SylwesterX <sylwesterx.dziedziuch@intel.com>; Palczewski,
> Mateusz <mateusz.palczewski@intel.com>; Zulinski, NorbertX
> <norbertx.zulinski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix NULL pointer dereference in
> i40e_dbg_dump_desc
> 
> From: Norbert Zulinski <norbertx.zulinski@intel.com>
> 
> When trying to dump VFs VSI RX/TX descriptors using debugfs there was a crash
> due to NULL pointer dereference in i40e_dbg_dump_desc.
> Added a check to i40e_dbg_dump_desc that checks if VSI type is correct for
> dumping RX/TX descriptors.
> 
> Fixes: 02e9c290814c ("i40e: debugfs interface")
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Norbert Zulinski <norbertx.zulinski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v2: Added missing signed-off-by tag
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
