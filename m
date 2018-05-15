From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 May 2018 22:53:56 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: release lock for the
 duration of ixgbe_suspend_close()
In-Reply-To: <20180503035931.22439-2-pasha.tatashin@oracle.com>
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
 <20180503035931.22439-2-pasha.tatashin@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B77152C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Pavel Tatashin
> Sent: Wednesday, May 2, 2018 9:00 PM
> To: pasha.tatashin at oracle.com; steven.sistare at oracle.com;
> daniel.m.jordan at oracle.com; linux-kernel at vger.kernel.org; Kirsher, Jeffrey
> T <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; gregkh at linuxfoundation.org
> Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: release lock for the duration of
> ixgbe_suspend_close()
> 
> Currently, during device_shutdown() ixgbe holds rtnl_lock for the duration of
> lengthy ixgbe_close_suspend(). On machines with multiple ixgbe cards this
> lock prevents scaling if device_shutdown() function is multi-threaded.
> 
> It is not necessary to hold this lock during ixgbe_close_suspend() as it is not
> held when ixgbe_close() is called also during shutdown but for kexec case.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


