From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 30 Jul 2015 16:56:07 +0000
Subject: [Intel-wired-lan] [PATCH V2 00/12] ixgbe: Add support for
 X550EM	devices with SFPs
In-Reply-To: <20150727190244.104300.81756.stgit@mdrustad-wks.jf.intel.com>
References: <20150727190244.104300.81756.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9ACE9@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>





> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Monday, July 27, 2015 12:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V2 00/12] ixgbe: Add support for X550EM
> devices with SFPs
> 
> The following patches add remaining bits of support for X550EM devices with
> SFPs. The last patch adds the device ID.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> 
> ---
> Changes in V2:
> - Added more changes that had been missed (9 more patches!)
> - Added latest CS4227 reset process
> ---
> 
> Mark D Rustad (12):
>       ixgbe: Accept SFP not present errors on all devices
>       ixgbe: Add X550EM support for SFP insertion interrupt
>       ixgbe: Provide I2C combined on X550EM
>       ixgbe: Provide unlocked I2C methods
>       ixgbe: Set lan_id before first I2C eeprom access
>       ixgbe: Enable bit-banging mode on X550
>       ixgbe: Clear I2C destination location
>       ixgbe: Allow reduced delays during sfp detection
>       ixgbe: Add X550EM_x dual-speed SFP+ support
>       ixgbe: Fix 1G and 10G link stability for X550EM_x SFP+
>       ixgbe: Add logic to reset CS4227 when needed
>       ixgbe: Add new X550EM SFP+ device ID
> 
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c  |  193 +---------
> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |  206 +++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |    5
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |    6
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c    |  284 +++++++++++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h    |   35 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |    6
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |  425
> +++++++++++++++++++++--
>  8 files changed, 907 insertions(+), 253 deletions(-)
> 
> --
> Mark Rustad, Network Division, Intel Corporation
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Some issues were found with these patches.
With SFI+ interface, seeing message:
invalid SFP+  "65535"
I believe Mark is investigating now.
Thanks,
Phillip Schmitt
