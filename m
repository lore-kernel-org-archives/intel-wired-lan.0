From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Aug 2016 17:28:47 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Eliminate useless message
	and	improve logic
In-Reply-To: <147224810290.93893.8237532391891649262.stgit@mdrustad-wks.jf.intel.com>
References: <147224810290.93893.8237532391891649262.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FAF18@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Friday, August 26, 2016 2:48 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Eliminate useless message and
> improve logic
> 
> Remove a useless log message and improve the logic for setting a PHY
> address from the contents of the MNG_IF_SEL register.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


