From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Apr 2016 20:57:33 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] ethtool/ixgbe: Reduce format
 string	storage
In-Reply-To: <20160421182856.13330.56812.stgit@ixgbe-dev.jf.intel.com>
References: <20160421182545.13330.59497.stgit@ixgbe-dev.jf.intel.com>
 <20160421182856.13330.56812.stgit@ixgbe-dev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2AC7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Preethi Banala
> Sent: Thursday, April 21, 2016 11:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/3] ethtool/ixgbe: Reduce format string
> storage
> 
> Reduce format string storage using for loop.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> ---
>  ixgbe.c |   57 ++++++++++++---------------------------------------------
>  1 file changed, 12 insertions(+), 45 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Ethtool reg dump shows correct information
