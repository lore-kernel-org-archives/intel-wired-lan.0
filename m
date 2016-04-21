From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Apr 2016 22:12:00 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: add WOL support for some
 82599	subdevice IDs
In-Reply-To: <20160421183706.21311.93388.stgit@localhost6.localdomain6>
References: <20160421183706.21311.93388.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2942@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, April 21, 2016 11:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: add WOL support for some
> 82599 subdevice IDs
> 
> We had some 82599 subdevice IDs missing from the list of parts that support
> WOL.
> 
> Reported-by: Neil Horman <nhorman@redhat.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 ++++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    6 +++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch applies and compiles correctly
