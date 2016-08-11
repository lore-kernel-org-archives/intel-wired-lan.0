From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Aug 2016 19:52:26 +0000
Subject: [Intel-wired-lan] [PATCH 1/1 v3] net: i40e: use matching
	format	identifiers
In-Reply-To: <1470870442-14539-1-git-send-email-xypron.glpk@gmx.de>
References: <1470851448.2128.15.camel@intel.com>
 <1470870442-14539-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F8A23@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Heinrich Schuchardt
> Sent: Wednesday, August 10, 2016 4:07 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>; Shannon Nelson
> <shannon.nelson@intel.com>; linux-kernel at vger.kernel.org; John Ronciak
> <john.ronciak@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; David Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH 1/1 v3] net: i40e: use matching format
> identifiers
> 
> i is defined as int but output as %u several times.
> Adjust the format identifiers.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> ---
> 
> v3:
> 	fix typos in title, old title:
> 	net: i10e: use matching format indentifiers
> 
> v2:
> 	Keep definition of i as int.
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 26 +++++++++++++---------
> ----
>  1 file changed, 13 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


