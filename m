From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Jul 2019 17:22:48 +0000
Subject: [Intel-wired-lan] [PATCH v2 05/10] ixgbe: modify driver for
 handling offsets
In-Reply-To: <20190716030637.5634-6-kevin.laatz@intel.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
 <20190716030637.5634-1-kevin.laatz@intel.com>
 <20190716030637.5634-6-kevin.laatz@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40C33D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Kevin Laatz
> Sent: Monday, July 15, 2019 8:07 PM
> To: netdev at vger.kernel.org; ast at kernel.org; daniel at iogearbox.net; Topel,
> Bjorn <bjorn.topel@intel.com>; Karlsson, Magnus
> <magnus.karlsson@intel.com>; jakub.kicinski at netronome.com;
> jonathan.lemon at gmail.com
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Loftus, Ciara
> <ciara.loftus@intel.com>; intel-wired-lan at lists.osuosl.org;
> bpf at vger.kernel.org; Laatz, Kevin <kevin.laatz@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 05/10] ixgbe: modify driver for handling
> offsets
> 
> With the addition of the unaligned chunks option, we need to make sure we
> handle the offsets accordingly based on the mode we are currently running
> in. This patch modifies the driver to appropriately mask the address for each
> case.
> 
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 26 ++++++++++++++++----
>  1 file changed, 21 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


