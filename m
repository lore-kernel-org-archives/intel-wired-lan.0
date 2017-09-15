From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 15 Sep 2017 00:27:46 +0000
Subject: [Intel-wired-lan] [PATCH 4/5] e1000e: Separate signaling for
 link check/link up
In-Reply-To: <20170802144922.txmee23d35o4r7mh@f1.synalogic.ca>
References: <20170721160937.GA22632@csclub.uwaterloo.ca>
 <20170721183627.13373-1-bpoirier@suse.com>
 <20170721183627.13373-4-bpoirier@suse.com>
 <14acedf3-e5d9-31e8-9ff6-fabc2127c021@intel.com>
 <20170802143437.ggdlmsszqinuvcmc@csclub.uwaterloo.ca>
 <20170802144922.txmee23d35o4r7mh@f1.synalogic.ca>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6A05C9@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 7/21/2017 21:36, Benjamin Poirier wrote:
> Lennart reported the following race condition:
>
> \ e1000_watchdog_task
>      \ e1000e_has_link
>          \ hw->mac.ops.check_for_link() === e1000e_check_for_copper_link
>              /* link is up */
>              mac->get_link_status = false;
>
>                              /* interrupt */
>                              \ e1000_msix_other
>                                  hw->mac.get_link_status = true;
>
>          link_active = !hw->mac.get_link_status
>          /* link_active is false, wrongly */
>
> This problem arises because the single flag get_link_status is used to
> signal two different states: link status needs checking and link status is
> down.
>
> Avoid the problem by using the return value of .check_for_link to signal
> the link status to e1000e_has_link().
>
> Reported-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>   drivers/net/ethernet/intel/e1000e/mac.c    | 11 ++++++++---
>   drivers/net/ethernet/intel/e1000e/netdev.c |  2 +-
>   2 files changed, 9 insertions(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
