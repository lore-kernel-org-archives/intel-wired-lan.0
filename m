From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 7 Dec 2021 10:04:31 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix problems with DSCP
 QoS implementation
In-Reply-To: <20211012203121.85155-1-david.m.ertman@intel.com>
References: <20211012203121.85155-1-david.m.ertman@intel.com>
Message-ID: <SN6PR11MB337477F0E24BB6FA755AAC9AFC6E9@SN6PR11MB3374.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Dave
> Ertman
> Sent: Wednesday, October 13, 2021 2:01 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix problems with DSCP QoS
> implementation
> 
> The patch that implemented DSCP QoS implementation removed a bandwidth
> check that was used to check for a specific condition caused by some corner
> cases.  This check should not of been removed.
> 
> The same patch also added a check for when the DCBx state could be changed
> in relation to DSCP, but the check was erroneously added nested in a check for
> CEE mode, which made the check useless.
> 
> Fix these problems by re-adding the bandwidth check and relocating the DSCP
> mode check earlier in the function that changes DCBx state in the driver.
> 
> Fixes: 2a87bd73e5 ("ice: Add DSCP support")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
