From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 20 Jun 2019 00:20:57 +0000
Subject: [Intel-wired-lan] [next v2] e1000e: Reduce boot time by
 tightening sleep ranges
In-Reply-To: <20190615002935.16397-1-jeffrey.t.kirsher@intel.com>
References: <20190615002935.16397-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970B077D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2019-06-14 at 17:29 -0700, Jeff Kirsher wrote:
> From: Arjan van de Ven <arjan@linux.intel.com>
> 
> The e1000e driver is a great user of the usleep_range() API,
> and has nice ranges that in principle help power management.
> 
> However the ranges that are used only during system startup are
> very long (and can add easily 100 msec to the boot time) while
> the power savings of such long ranges is irrelevant due to the
> one-off, boot only, nature of these functions.
> 
> This patch shrinks some of the longest ranges to be shorter
> (while still using a power friendly 1 msec range); this saves
> 100msec+ of boot time on my BDW NUCs
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v2: fixed up patch to apply cleanly to the upstream e1000e driver
> 
>  .../net/ethernet/intel/e1000e/80003es2lan.c   |  2 +-
>  drivers/net/ethernet/intel/e1000e/82571.c     |  2 +-
>  drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 ++++++-------
>  drivers/net/ethernet/intel/e1000e/ich8lan.c   | 20 +++++++++----------
>  drivers/net/ethernet/intel/e1000e/mac.c       |  2 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c    | 14 ++++++-------
>  drivers/net/ethernet/intel/e1000e/nvm.c       |  2 +-
>  7 files changed, 28 insertions(+), 28 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
- While I don't have access to every e1000e SKU I do have at lease a dozen different ones dating back quite a few generations and this does not seem to introduce any issues. 
