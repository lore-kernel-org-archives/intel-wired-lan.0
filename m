From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 16 Feb 2022 08:42:28 +0000
Subject: [Intel-wired-lan] [PATCH] ice: fix concurrent reset and removal
 of VFs
In-Reply-To: <20220207182329.2078272-1-jacob.e.keller@intel.com>
References: <20220207182329.2078272-1-jacob.e.keller@intel.com>
Message-ID: <DM8PR11MB56212493571FC633D8ADFC7EAB359@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Monday, February 7, 2022 7:23 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH] ice: fix concurrent reset and removal of
> VFs
> 
> Commit c503e63200c6 ("ice: Stop processing VF messages during teardown")
> introduced a driver state flag, ICE_VF_DEINIT_IN_PROGRESS, which is
> intended to prevent some issues with concurrently handling messages from
> VFs while tearing down the VFs.
> 
> This change was motivated by crashes caused while tearing down and
> bringing up VFs in rapid succession.
> 
> It turns out that the fix actually introduces issues with the VF driver caused
> because the PF no longer responds to any messages sent by the VF during its
> .remove routine. This results in the VF potentially removing its DMA memory
> before the PF has shut down the device queues.
> 
> Additionally, the fix doesn't actually resolve concurrency issues within the ice
> driver. It is possible for a VF to initiate a reset just prior to the ice driver
> removing VFs. This can result in the remove task concurrently operating
> while the VF is being reset. This results in similar memory corruption and
> panics purportedly fixed by that commit.
> 
> Fix this concurrency at its root by protecting both the reset and removal
> flows using the existing VF cfg_lock. This ensures that we cannot remove the
> VF while any outstanding critical tasks such as a virtchnl message or a reset
> are occurring.
> 
> This locking change also fixes the root cause originally fixed by commit
> c503e63200c6 ("ice: Stop processing VF messages during teardown"), so we
> can simply revert it.
> 
> Note that I kept these two changes together because simply reverting the
> original commit alone would leave the driver vulnerable to worse race
> conditions.
> 
> Fixes: c503e63200c6 ("ice: Stop processing VF messages during teardown")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  1 -
>  drivers/net/ethernet/intel/ice/ice_main.c     |  2 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 40 +++++++++++--------
>  3 files changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index a9fa701aaa95..473b1f6be9de 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
