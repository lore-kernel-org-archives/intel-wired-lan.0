From: Bynoe, Ronald J <ronald.j.bynoe@intel.com>
Date: Wed, 21 Sep 2016 19:28:46 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix configure TCs after initial
 DCB disable
In-Reply-To: <1474380650-8771-1-git-send-email-david.m.ertman@intel.com>
References: <1474380650-8771-1-git-send-email-david.m.ertman@intel.com>
Message-ID: <1474486126.2485.10.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-09-20 at 07:10 -0700, Dave Ertman wrote:
> in commit a036244c068612a43fa8c0f33a0eb4daa4d8dba0 a fix
> was put into place to avoid a kernel panic when a non-
> supported traffic class configuration was put into place
> and then lldp was enabled/disabled on the link partner
> switch.??This fix caused it to be necessary to
> unload/reload the driver to reenable DCB once a supported
> TC config was in place.
> 
> The root cause of the original panic was that the function
> i40e_pf_get_default_tc was allowing for a default TC other
> than TC 0, and only TC 0 is supported as a default.
> 
> This patch removes the get_default_tc function and replaces
> it with a #define since there is only one TC supported as
> a default.
> 
> Change-Id: I448371974e946386d0a7718d73668b450b7c72ef
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
> ?drivers/net/ethernet/intel/i40e/i40e.h??????|??1 +
> ?drivers/net/ethernet/intel/i40e/i40e_main.c | 31 ++++---------------
> ----------
> ?2 files changed, 5 insertions(+), 27 deletions(-)

Tested-by: Ronald Bynoe <ronald.j.bynoe@intel.com>
