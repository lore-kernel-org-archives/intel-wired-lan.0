From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 27 Sep 2018 16:12:10 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: check return value of
 napi_complete_done()
In-Reply-To: <20180920190113.490005-1-songliubraving@fb.com>
References: <20180920190113.490005-1-songliubraving@fb.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC880@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Song Liu
> Sent: Thursday, September 20, 2018 12:01 PM
> To: netdev at vger.kernel.org
> Cc: Song Liu <songliubraving@fb.com>; intel-wired-lan at lists.osuosl.org;
> kernel-team at fb.com; stable at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: check return value of
> napi_complete_done()
> 
> The NIC driver should only enable interrupts when napi_complete_done()
> returns true. This patch adds the check for ixgbe.
> 
> Cc: stable at vger.kernel.org # 4.10+
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


