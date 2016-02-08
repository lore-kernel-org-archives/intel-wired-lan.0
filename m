From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Feb 2016 16:55:34 +0000
Subject: [Intel-wired-lan] [PATCH net-next V2 1/6] i40e: call
	ndo_stop()	instead of dev_close() when running offline selftest
In-Reply-To: <1454487652-1545-2-git-send-email-sassmann@kpanic.de>
References: <1454487652-1545-1-git-send-email-sassmann@kpanic.de>
 <1454487652-1545-2-git-send-email-sassmann@kpanic.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98E6BB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Stefan Assmann
> Sent: Wednesday, February 03, 2016 12:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH net-next V2 1/6] i40e: call ndo_stop()
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
>  drivers/net/ethernet/intel/i40e/i40e.h         | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 4 ----
>  3 files changed, 3 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Interface did not drop addresses/routes during offline ethtool self-test.
