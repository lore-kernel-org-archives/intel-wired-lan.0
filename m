From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Dec 2016 21:46:37 +0000
Subject: [Intel-wired-lan] [next PATCH S55 05/14] i40e: refactor
	macro	INTRL_USEC_TO_REG
In-Reply-To: <1480377971-23412-6-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
 <1480377971-23412-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38FDD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 28, 2016 4:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Brady, Alan <alan.brady@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S55 05/14] i40e: refactor macro
> INTRL_USEC_TO_REG
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> This patch refactors the macro INTRL_USEC_TO_REG into a static inline
> function and fixes a couple subtle bugs caused by the macro.
> 
> This patch fixes a bug which was caused by passing a bad register value to the
> firmware.  If enabling interrupt rate limiting, a non-zero value for the rate
> limit must be used.  Otherwise the firmware sets the interrupt rate limit to
> the maximum value.  Due to the limited resolution of the register,
> attempting to set a value of 1, 2, or 3 would be rounded down to 0 and
> limiting was left enabled, causing unexpected behavior.
> 
> This patch also fixes a possible bug in which using the macro itself can
> introduce unintended side-affects because the macro argument is used
> more than once in the macro definition (e.g. a variable post-increment
> argument would perform a double increment on the variable).
> 
> Without this patch, attempting to set interrupt rate limits of 1, 2, or
> 3 results in unexpected behavior and future use of this macro could cause
> subtle bugs.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-Id: I83ac842de0ca9c86761923d6e3a4d7b1b95f2b3f
> ---
> Testing-hints:
> Use 'ethtool -C ethx rx-usecs-high xxx' to set different values for the rate
> limit and 'idb ethx read 0x00035800' to observe register PFINT_RATEN for
> values of 1, 2, 3, compared to 0 and 4.
> 
> HSDES-number: 1208935557
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 15 ++++++++++++++-
>  3 files changed, 16 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


