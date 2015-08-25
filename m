From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Tue, 25 Aug 2015 22:51:25 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for reporting
	2.5G	link speed
In-Reply-To: <20150710211921.35052.49163.stgit@mdrustad-wks.jf.intel.com>
References: <20150710211921.35052.49163.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <87618083B2453E4A8714035B62D679925038F0A3@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>Behalf Of Mark D Rustad
>Sent: Friday, July 10, 2015 2:19 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for reporting 2.5G
>link speed
>
>Now that we can do 2.5G link speed, we need to be able to report it.
>Also change the nested triadic involved in creating the log message
>to instead use a simpler switch statement to set a string pointer.
>
>Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    7 ++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   27 +++++++++++++++---
>----
> 2 files changed, 26 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>index f7aeb560a504..cfdd79f24ec1 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>@@ -166,6 +166,8 @@ static int ixgbe_get_settings(struct net_device
>*netdev,
> 	/* set the supported link speeds */
> 	if (supported_link & IXGBE_LINK_SPEED_10GB_FULL)
> 		ecmd->supported |= SUPPORTED_10000baseT_Full;
>+	if (supported_link & IXGBE_LINK_SPEED_2_5GB_FULL)
>+		ecmd->supported |= SUPPORTED_2500baseX_Full;
> 	if (supported_link & IXGBE_LINK_SPEED_1GB_FULL)
> 		ecmd->supported |= SUPPORTED_1000baseT_Full;
> 	if (supported_link & IXGBE_LINK_SPEED_100_FULL)

2.5Gbps is supported on BASE-T and BASE-KX, not BASE-X, we probably need
to add support in ethtool first.
 
Also setting ecmd->supported will allow the user to set the speed using the
"advertise" option which as far as I know is not supported.

NACK - based on the above.

Thanks,
Emil


