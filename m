From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 25 Jan 2016 22:19:08 +0000
Subject: [Intel-wired-lan] [next PATCH S28 06/15] i40e: Fix PROMISC mode
 for	Multi-function per port (MFP) devices
In-Reply-To: <1452897202-15204-7-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-7-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C4B3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, January 15, 2016 2:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S28 06/15] i40e: Fix PROMISC mode
> for Multi-function per port (MFP) devices
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This patch falls back to enabling unicast, multicast and broadcast promiscuous
> mode when the driver must disable it's use of "default port" aka defport
> mode (which is mornally used to provide a promiscuous mode), due to
> internal incompatibility with Multiple Function per Port (aka MFP).
> 
> The situation that requires this patch is when Physical Function 0 is the device
> being used, and it can support SR-IOV when MFP is enabled, via the driver
> creating a VEB on an MFP enabled adapter.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: Ie90b00d0d58782a5dfcf2c3c9725a2eb90bd63d8
> ---
> Testing Hints:
> With our driver defaulting to set_switch_config with Promisc except when L2
> filters match, we do not expect to see any mirroring of VF traffic in the PF
> since the DCR doesn't make an exception for MFP case. If we see mirroring
> than we need to file a separate issue with the HW team.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, no mirroring of VF traffic in PF observed.
