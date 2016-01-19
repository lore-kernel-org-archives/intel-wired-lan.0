From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Jan 2016 21:40:38 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S27 03/15] i40e: set shared
 bit	for multicast filters
In-Reply-To: <1452732712-12248-4-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
 <1452732712-12248-4-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F980911@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, January 13, 2016 4:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S27 03/15] i40e: set shared bit for
> multicast filters
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add the use of the new Shared MAC filter bit for multicast and broadcast
> filters in order to make better use of the filters available from the device.
> The FW folks have assured me that setting this bit on older FW will have no
> affect, so we don't need a version check.
> 
> Also fixed a stray indent problem nearby.
> 
> Also update copyright year.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I4c5826a32594382a7937a592a24d228588cee7aa
> ---
> Testing Hints (required if no HSD):
> 	Disable link polling: ethtool --set-priv-flags p261p1 LinkPolling off
> 	Eanble AQ debug: ethtool -s p261p1 msglvl 0xff00000f
> 	Add a new vlan: ip link add link p261p1 name p261p1.v10 type vlan id
> 10
> 		This will generate an add macvlan request and dump the
> trace
> 		in dmesg.  Make sure that the value in byte 8 for multicast
> 		and broadcast addresses is '11' as shown here:
>     14594.033921] i40e 00.0        0x0010  FF FF FF FF FF FF 0A 00 11 00 00 00 00 00
> 00 00
>     		and should be '01' for unicast address.  If running on older
> 		firmware, e.g. FVL4, this byte will always be '01'.
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, correct information shown in trace dump
