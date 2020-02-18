From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 18 Feb 2020 14:56:51 -0800
Subject: [Intel-wired-lan] [net-queue v4] ice: Wait for VF to be
 reset/ready before configuration
In-Reply-To: <20200218225059.1294769-1-jeffrey.t.kirsher@intel.com>
References: <20200218225059.1294769-1-jeffrey.t.kirsher@intel.com>
Message-ID: <c78f27ad9d3eeccdbe85ec5d393fbcc9fac662a5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2020-02-18 at 14:50 -0800, Jeff Kirsher wrote:
> From: Brett Creeley <brett.creeley@intel.com>
> 
> The configuration/command below is failing when the VF in the xml
> file is already bound to the host iavf driver.
> 
> pci_0000_af_0_0.xml:
> 
> <interface type='hostdev' managed='yes'>
> <source>
> <address type='pci' domain='0x0000' bus='0xaf' slot='0x0'
> function='0x0'/>
> </source>
> <mac address='00:de:ad:00:11:01'/>
> </interface>
> 
> > virsh attach-device domain_name pci_0000_af_0_0.xml
> error: Failed to attach device from pci_0000_af_0_0.xml
> error: Cannot set interface MAC/vlanid to 00:de:ad:00:11:01/0 for
>         ifname ens1f1 vf 0: Device or resource busy
> 
> This is failing because the VF has not been completely removed/reset
> after being unbound (via the virsh command above) from the host iavf
> driver and ice_set_vf_mac() checks if the VF is disabled before
> waiting
> for the reset to finish.
> 
> Fix this by waiting for the VF remove/reset process to happen before
> checking if the VF is disabled. Also, since many functions for VF
> administration on the PF were more or less calling the same 3
> functions
> (ice_wait_on_vf_reset(), ice_is_vf_disabled(), and
> ice_check_vf_init())
> move these into the helper function ice_check_vf_ready_for_cfg().
> Then
> call this function in any flow that attempts to configure/query a VF
> from the PF.
> 
> Lastly, increase the maximum wait time in ice_wait_on_vf_reset() to
> 800ms, and modify/add the #define(s) that determine the wait time.
> This was done for robustness because in rare/stress cases VF removal
> can
> take a max of ~800ms and previously the wait was a max of ~300ms.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>

Disregard this submission, I put the wrong change log below on this
patch and this was supposed to be v3, not v4.  I have already submitted
the correct version, with the correct change log.

> ---
> v2: add SKB_GSO_UDP_L4 to features check and probe
> v3: patch did not apply cleanly to next-queue tree, due to other igc
>     patches that had been applied, so fixed up the patch to apply
> cleanly
> v4: fixed two return values, which should have returned 0 (Success)
> 
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 127 ++++++++++----
> ----
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   3 +-
>  2 files changed, 73 insertions(+), 57 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200218/651498c0/attachment.asc>
