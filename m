From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Apr 2016 20:56:41 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] ethtool/ixgbe: Correct offsets
 and support x550, x550em_x, x550em_a
In-Reply-To: <20160421182851.13330.71861.stgit@ixgbe-dev.jf.intel.com>
References: <20160421182545.13330.59497.stgit@ixgbe-dev.jf.intel.com>
 <20160421182851.13330.71861.stgit@ixgbe-dev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2AB7@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 2/3] ethtool/ixgbe: Correct offsets and
> support x550, x550em_x, x550em_a
> 
> Correct hard-coded wrong offset values and add several conditions to display
> registers for x550, x550em_x and x550em_a based on datasheet/ EAS
> document.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> ---
>  ixgbe.c |   74 +++++++++++++++++++++++++++++++++++---------------------
> -------
>  1 file changed, 41 insertions(+), 33 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Ethtool reg dump shows added information and correct offsets
