From: Kiyanovski, Arthur <akiyano@amazon.com>
Date: Thu, 11 Mar 2021 13:42:21 +0000
Subject: [Intel-wired-lan] [RFC PATCH 05/10] ena: Update driver to use
 ethtool_gsprintf
In-Reply-To: <161542654541.13546.817443057977441498.stgit@localhost.localdomain>
References: <161542634192.13546.4185974647834631704.stgit@localhost.localdomain>
 <161542654541.13546.817443057977441498.stgit@localhost.localdomain>
Message-ID: <a8d66ff7d2034b75ada799de8b9de448@EX13D22EUA004.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Alexander Duyck <alexander.duyck@gmail.com>
> Sent: Thursday, March 11, 2021 3:36 AM
> To: kuba at kernel.org
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
> alexanderduyck at fb.com
> Subject: [EXTERNAL] [RFC PATCH 05/10] ena: Update driver to use
> ethtool_gsprintf
> 
> CAUTION: This email originated from outside of the organization. Do not click
> links or open attachments unless you can confirm the sender and know the
> content is safe.
> 
> 
> 
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Replace instances of snprintf or memcpy with a pointer update with
> ethtool_gsprintf.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Acked-by: Arthur Kiyanovski <akiyano@amazon.com>
