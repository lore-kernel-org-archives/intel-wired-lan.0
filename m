From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Apr 2016 17:32:51 +0000
Subject: [Intel-wired-lan] [PATCH v2 03/13] ixgbevf: make use of BIT()
 macro	to avoid shift of signed values
In-Reply-To: <1460588914-20143-4-git-send-email-jacob.e.keller@intel.com>
References: <1460588914-20143-1-git-send-email-jacob.e.keller@intel.com>
 <1460588914-20143-4-git-send-email-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D25A4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Wednesday, April 13, 2016 4:08 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v2 03/13] ixgbevf: make use of BIT() macro
> to avoid shift of signed values
> 
> Also cleanup a case where we're bit shifting a value into place, and use an
> unsigned constant. Make use of the unsigned postfix in places where
> BIT() macro is not appropriate.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/defines.h      | 22 +++++++++++-----------
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c      |  3 ++-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  8 ++++----
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 18 +++++++++---------
>  4 files changed, 26 insertions(+), 25 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver compiles without shift warnings
