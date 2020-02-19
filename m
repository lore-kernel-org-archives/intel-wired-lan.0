From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:30:42 +0000
Subject: [Intel-wired-lan] [net v4] ice: Wait for VF to be reset/ready
 before configuration
In-Reply-To: <20200219001124.1610130-1-jeffrey.t.kirsher@intel.com>
References: <20200219001124.1610130-1-jeffrey.t.kirsher@intel.com>
Message-ID: <3515ea1a533f44c99a49ed83d4d230c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, February 18, 2020 4:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Creeley, Brett <brett.creeley@intel.com>
> Subject: [Intel-wired-lan] [net v4] ice: Wait for VF to be reset/ready before
> configuration
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> The configuration/command below is failing when the VF in the xml file is
> already bound to the host iavf driver.
> 
> pci_0000_af_0_0.xml:
> 
> <interface type='hostdev' managed='yes'> <source> <address type='pci'
> domain='0x0000' bus='0xaf' slot='0x0' function='0x0'/> </source> <mac
> address='00:de:ad:00:11:01'/> </interface>
> 
> > virsh attach-device domain_name pci_0000_af_0_0.xml
> error: Failed to attach device from pci_0000_af_0_0.xml
> error: Cannot set interface MAC/vlanid to 00:de:ad:00:11:01/0 for
> 	ifname ens1f1 vf 0: Device or resource busy
> 
> This is failing because the VF has not been completely removed/reset after
> being unbound (via the virsh command above) from the host iavf driver and
> ice_set_vf_mac() checks if the VF is disabled before waiting for the reset to
> finish.
> 
> Fix this by waiting for the VF remove/reset process to happen before
> checking if the VF is disabled. Also, since many functions for VF
> administration on the PF were more or less calling the same 3 functions
> (ice_wait_on_vf_reset(), ice_is_vf_disabled(), and ice_check_vf_init())
> move these into the helper function ice_check_vf_ready_for_cfg(). Then call
> this function in any flow that attempts to configure/query a VF from the PF.
> 
> Lastly, increase the maximum wait time in ice_wait_on_vf_reset() to 800ms,
> and modify/add the #define(s) that determine the wait time.
> This was done for robustness because in rare/stress cases VF removal can
> take a max of ~800ms and previously the wait was a max of ~300ms.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
> v2: Original patch did not apply cleanly to my net-queue tree, so it had
>     to be applied by hand, this version applies cleanly to net-queue
> v3: fixed two return values, which should have returned 0 (Success)
> v4: Brett cleaned up the use of "goto's" and simply returned the current
>     'ret' value
> 
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 134 ++++++++++--------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   3 +-
>  2 files changed, 76 insertions(+), 61 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


