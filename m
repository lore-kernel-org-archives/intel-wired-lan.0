From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 20:57:10 +0000
Subject: [Intel-wired-lan] [next PATCH S12 11/15] i40e: Fix multiple
 link up	messages
In-Reply-To: <1440690163-128213-12-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-12-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5E1C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, August 27, 2015 8:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jared, Matthew A
> Subject: [Intel-wired-lan] [next PATCH S12 11/15] i40e: Fix multiple link up
> messages
> 
> From: Matt Jared <matthew.a.jared@intel.com>
> 
> This patch addresses an issue where multiple link up messages can be logged
> resulting from aq link status timing when link properties are changed (fc,
> speed, etc.); solved by using a single function to handle status printing and
> adding a mechanism to track whether link state (up or down) has actually
> changed.
> 
> Signed-off-by: Matt Jared <matthew.a.jared@intel.com>
> Change-ID: Ied6ed6e49dc397c77d992adc0bc9ed3767152b9d
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 2 ++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 5 ++++-
>  3 files changed, 8 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, changing parameters does not result in multiple link up  messages.
