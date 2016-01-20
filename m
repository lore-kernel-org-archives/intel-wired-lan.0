From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 22:43:42 +0000
Subject: [Intel-wired-lan] [next PATCH S28 08/15] i40e/i40evf: avoid
 atomics
In-Reply-To: <1452897202-15204-9-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-9-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F989C9F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, January 15, 2016 2:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S28 08/15] i40e/i40evf: avoid atomics
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> In the case where we have a page fully used by receive data, we need to
> release the page fully to the stack. Instead of calling get_page (which
> increments the page count) followed by free_page (which decrements the
> page count), just donate our reference to the stack. Although this donation is
> not tax deductable, it does allow us to avoid two very expensive atomic
> operations that reverse each other.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: If70739792d5748995fc175ec92ac2171ed4ad8fc
> ---
> Testing Hints: make sure receive traffic is stable under heavy load with
> packet split enabled, and that no data corruption is seen.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 21 +++++++++++++--------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 21 +++++++++++++--------
>  2 files changed, 26 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, heavy load traffic stable, no corruption observed
