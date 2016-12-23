From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 23 Dec 2016 17:22:22 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: update the rss key on h/w,
	when ethtool ask for it.
In-Reply-To: <1aee550aa286aa44265236441b42f8aab77ae864.1481796580.git.pabeni@redhat.com>
References: <1aee550aa286aa44265236441b42f8aab77ae864.1481796580.git.pabeni@redhat.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA4C1A3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Paolo Abeni
> Sent: Thursday, December 15, 2016 6:21 AM
> To: netdev at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: update the rss key on h/w,
> when ethtool ask for it.
> 
> Currently ixgbe_set_rxfh() updates the rss_key copy in the driver memory,
> but does not push the new value into the h/w. This commit add a new helper
> for the latter operation and call it in ixgbe_set_rxfh(), so that the h/w rss key
> value can be really updated via ethtool.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  4 +++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 19 ++++++++++++++++--
> -
>  3 files changed, 20 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Verified ethtool hash key correlates with hash key in firmware register with Lanconf


