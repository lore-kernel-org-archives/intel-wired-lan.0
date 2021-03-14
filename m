From: Kiyanovski, Arthur <akiyano@amazon.com>
Date: Sun, 14 Mar 2021 08:30:46 +0000
Subject: [Intel-wired-lan] [net-next PATCH 05/10] ena: Update driver to
 use ethtool_sprintf
In-Reply-To: <161557131360.10304.1549281998235246752.stgit@localhost.localdomain>
References: <161557111604.10304.1798900949114188676.stgit@localhost.localdomain>
 <161557131360.10304.1549281998235246752.stgit@localhost.localdomain>
Message-ID: <c0aefd974f084847b213e3e841644830@EX13D22EUA004.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Alexander Duyck <alexander.duyck@gmail.com>
> Sent: Friday, March 12, 2021 7:49 PM
> To: davem at davemloft.net; kuba at kernel.org
> Cc: netdev at vger.kernel.org; oss-drivers at netronome.com;
> simon.horman at netronome.com; yisen.zhuang at huawei.com;
> salil.mehta at huawei.com; intel-wired-lan at lists.osuosl.org;
> jesse.brandeburg at intel.com; anthony.l.nguyen at intel.com;
> drivers at pensando.io; snelson at pensando.io; Belgazal, Netanel
> <netanel@amazon.com>; Kiyanovski, Arthur <akiyano@amazon.com>;
> Tzalik, Guy <gtzalik@amazon.com>; Bshara, Saeed <saeedb@amazon.com>;
> GR-Linux-NIC-Dev at marvell.com; skalluru at marvell.com;
> rmody at marvell.com; kys at microsoft.com; haiyangz at microsoft.com;
> sthemmin at microsoft.com; wei.liu at kernel.org; mst at redhat.com;
> jasowang at redhat.com; pv-drivers at vmware.com; doshir at vmware.com;
> alexanderduyck at fb.com; Kernel-team at fb.com
> Subject: [EXTERNAL] [net-next PATCH 05/10] ena: Update driver to use
> ethtool_sprintf
> 
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Replace instances of snprintf or memcpy with a pointer update with
> ethtool_sprintf.
> 
> Acked-by: Arthur Kiyanovski <akiyano@amazon.com>
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_ethtool.c |   25 +++++++++++-------
> -------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
Acked-by: Arthur Kiyanovski <akiyano@amazon.com>
