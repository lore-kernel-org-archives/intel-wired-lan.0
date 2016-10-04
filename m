From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 4 Oct 2016 19:01:51 +0000
Subject: [Intel-wired-lan] [net-next PATCH v3] i40e: Clean up handling
 of msglevel flags and debug parameter
In-Reply-To: <20160930122104.12039.57727.stgit@ahduyck-blue-test.jf.intel.com>
References: <20160930122104.12039.57727.stgit@ahduyck-blue-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0F7CB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, September 30, 2016 5:22 AM
> To: sassmann at kpanic.de; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [net-next PATCH v3] i40e: Clean up handling of
> msglevel flags and debug parameter
> 
> So the i40e driver had a really convoluted configuration for how to handle the
> debug flags contained in msg_level.  Part of the issue is that the driver has its
> own 32 bit mask that it was using to track a separate set of debug features.
> From what I can tell it was trying to use the upper 4 bits to determine if the
> value was meant to represent a bit-mask or the numeric value provided by
> debug level.
> 
> What this patch does is clean this up by compressing those 4 bits into bit 31,
> as a result we just have to perform a check against the value being negative
> to determine if we are looking at a debug level (positive), or a debug mask
> (negative).  The debug level will populate the msg_level, and the debug
> mask will populate the debug_mask in the hardware struct.
> 
> I added similar logic for ethtool.  If the value being provided has bit 31 set we
> assume the value being provided is a debug mask, otherwise we assume it is
> a msg_enable mask.  For displaying we only provide the msg_enable, and if
> debug_mask is in use we will print it to the dmesg log.
> 
> Lastly I removed the debugfs interface.  It is redundant with what we already
> have in ethtool and really doesn't belong anyway.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> v2: Consolidated setup for msg_enable and hw.debug_mask to one point in
> probe.
> v3: Removed msg_enable from list of debugfs commands listed.
> 
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |   19 -------------------
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |    7 ++++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |   23 ++++++++---------------
>  3 files changed, 14 insertions(+), 35 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Works as described, functions removed from debugfs commands


