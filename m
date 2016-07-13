From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jul 2016 15:12:07 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: napi_poll must return the
 work	done
In-Reply-To: <37ccedd746ed932b9d73eff592f324f2a3fc6c6f.1465995724.git.pabeni@redhat.com>
References: <37ccedd746ed932b9d73eff592f324f2a3fc6c6f.1465995724.git.pabeni@redhat.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EA4DA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Paolo Abeni
> Sent: Wednesday, June 15, 2016 6:38 AM
> To: netdev at vger.kernel.org
> Cc: Hannes Frederic Sowa <hannes@redhat.com>; intel-wired-
> lan at lists.osuosl.org; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: napi_poll must return the work
> done
> 
> Currently the function ixgbe_poll() returns 0 when it clean completely the rx
> rings, but this foul budget accounting in core code.
> Fix this returning the actual work done, capped to weight - 1, since the core
> doesn't allow to return the full budget when the driver modifies the napi
> status
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
