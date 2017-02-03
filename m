From: Pujari, Bimmy <bimmy.pujari@intel.com>
Date: Fri, 3 Feb 2017 18:00:55 +0000
Subject: [Intel-wired-lan] [next PATCH S60 1/1] i40e: rename
 auto_disable_flags to hw_disabled_flags
In-Reply-To: <1486030706.2409.14.camel@intel.com>
References: <1486016013-11773-1-git-send-email-bimmy.pujari@intel.com>
 <1486030706.2409.14.camel@intel.com>
Message-ID: <B759292EEECB5C46AEDF3EC46470BC94B02B3F@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sent a new version of this patch to you. Hopefully this one works.

Regards
Bimmy


-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Thursday, February 2, 2017 2:18 AM
To: Pujari, Bimmy <bimmy.pujari@intel.com>; intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [next PATCH S60 1/1] i40e: rename auto_disable_flags to hw_disabled_flags

On Wed, 2017-02-01 at 22:13 -0800, Bimmy Pujari wrote:
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> A previous commit introduced a field that tracks the features that are 
> disabled due to HW resource limitations as opposed to the featured 
> disabled by the user. This patch changes the name of the field to make 
> it more readable since it might get confusing when looking at code 
> containing both the flags field and the auto_disable_features field 
> together.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> Change-ID: Idcc9888659698f6fe3ccff17c8c3f09b5026f708
> ---
> ?drivers/net/ethernet/intel/i40e/i40e.h???????? |? 8 ++++++--
> ?drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 ++++-----
> ?drivers/net/ethernet/intel/i40e/i40e_main.c??? | 28 
> +++++++++++++-------
> ------
> ?drivers/net/ethernet/intel/i40e/i40e_txrx.c??? | 20 
> +++++++++---------
> ?4 files changed, 35 insertions(+), 31 deletions(-)

This does not apply cleanly at all, so I am dropping this patch.
