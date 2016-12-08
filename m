From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Dec 2016 18:14:53 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: add mask for 64 RSS queues
In-Reply-To: <20161104210303.10489.64989.stgit@localhost6.localdomain6>
References: <20161104210303.10489.64989.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39B1C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, November 04, 2016 2:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: add mask for 64 RSS queues
> 
> The indirection table was reported incorrectly for X550 and newer where we
> can support up to 64 RSS queues.
> 
> Reported-by Krishneil Singh <krishneil.k.singh@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

