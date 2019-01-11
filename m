From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Jan 2019 18:46:22 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: remove magic constant in
 ixgbe_reset_hw_82599()
In-Reply-To: <nycvar.YFH.7.76.1901022016380.14047@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901022016380.14047@cbobk.fhfr.pm>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3510C4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jiri Kosina
> Sent: Wednesday, January 2, 2019 11:21 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: remove magic constant in
> ixgbe_reset_hw_82599()
> 
> From: Jiri Kosina <jkosina@suse.cz>
> 
> ixgbe_reset_hw_82599() resets the value of hw->mac.num_rar_entries to
> pre-defined value of 128. Let's get rid of that hardcoded literal, and use
> IXGBE_82599_RAR_ENTRIES instead, the same way the normal initialization
> path does.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


