From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Aug 2016 16:11:31 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: use atomic bitwise operations
 when handling reset requests
In-Reply-To: <20160729214631.1864.51421.stgit@localhost6.localdomain6>
References: <20160729214631.1864.51421.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F8985@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, July 29, 2016 2:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: use atomic bitwise operations
> when handling reset requests
> 
> Use atomic bitwise operations when setting and checking reset requests.
> This should help with possible races in the service task.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   16 +++++++---------
>  2 files changed, 8 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


