From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 10 Jan 2018 00:35:13 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Don't report unsupported
 timestamping filters for X550
In-Reply-To: <20180109113705.8464-1-mlichvar@redhat.com>
References: <20180109113705.8464-1-mlichvar@redhat.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D8046@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Miroslav Lichvar
> Sent: Tuesday, January 9, 2018 3:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Richard Cochran <richardcochran@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Don't report unsupported
> timestamping filters for X550
> 
> The current code enables on X550 timestamping of all packets for any filter,
> which means ethtool should not report any PTP-specific filters as supported.
> 
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 37 ++++++++++++-------
> -----
>  1 file changed, 19 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


