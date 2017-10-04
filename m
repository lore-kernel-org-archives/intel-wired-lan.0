From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 Oct 2017 19:25:06 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix crash when injecting AER
 after	failed reset
In-Reply-To: <20170929175542.17801.97091.stgit@localhost6.localdomain6>
References: <20170929175542.17801.97091.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EABB1D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, September 29, 2017 10:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix crash when injecting AER after
> failed reset
> 
> In case where AER recovery fails the device is left in a down state.
> Consecutive AER error injection can lead to a double IRQ free.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


