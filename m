From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 1 Mar 2016 19:36:38 +0000
Subject: [Intel-wired-lan] [PATCH net-next 3/6] ixgbevf: call
	ndo_stop()	instead of dev_close() when running offline selftest
In-Reply-To: <1454408028-16986-4-git-send-email-sassmann@kpanic.de>
References: <1454408028-16986-1-git-send-email-sassmann@kpanic.de>
 <1454408028-16986-4-git-send-email-sassmann@kpanic.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99C1C3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Stefan Assmann
> Sent: Tuesday, February 02, 2016 2:14 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH net-next 3/6] ixgbevf: call ndo_stop()
> instead of dev_close() when running offline selftest
> 
> Calling dev_close() causes IFF_UP to be cleared which will remove the
> interfaces routes and some addresses. That's probably not what the user
> intended when running the offline selftest. Besides this does not happen if
> the interface is brought down before the test, so the current behaviour is
> inconsistent.
> Instead call the net_device_ops ndo_stop function directly and avoid
> touching IFF_UP at all.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c      | 4 ++--
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 2 ++
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++--
>  3 files changed, 6 insertions(+), 4 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
ethtool offline selftest does not wipe information from interface (route, etc...)
