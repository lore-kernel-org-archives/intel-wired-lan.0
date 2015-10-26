From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Oct 2015 18:48:28 +0000
Subject: [Intel-wired-lan] [next PATCH S19 08/15] i40e: Move the saving
 of	old link info from handle_link_event to link_event
In-Reply-To: <1445471236-35918-9-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
 <1445471236-35918-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D3EAE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, October 21, 2015 4:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S19 08/15] i40e: Move the saving of
> old link info from handle_link_event to link_event
> 
> The watchdog only calls link_event not handle_link_event which means that
> we need to save the old information in link_event.
> 
> Previously when polling we were comparing current data to the old data
> saved the last time we actually received a link event. This means that the
> polling would only fix link status changes in one direction depending on what
> the last old data saved off was.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: Ie590f30fdbcb133d0ddad4e07e3eb1aad58255b3
> 
> ---
> Testing-hints: Play with link a bit (forcing it up and down and such) and make
> sure htat it is reporting the expected state in ethtool <dev>.
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, ethtool shows correct link state
