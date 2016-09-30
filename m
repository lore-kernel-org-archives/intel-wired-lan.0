From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 30 Sep 2016 17:53:39 +0000
Subject: [Intel-wired-lan] [next PATCH S48 1/7] i40e: fix confusing
 dmesg	info for ethtool -L option
In-Reply-To: <1475000934-27335-2-git-send-email-bimmy.pujari@intel.com>
References: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
 <1475000934-27335-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0F4EA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, September 27, 2016 11:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S48 1/7] i40e: fix confusing dmesg info
> for ethtool -L option
> 
> From: Lihong Yang <lihong.yang@intel.com>
> 
> Ethtool -L option with the combined parameter is for changing the number of
> multi-purpose channels of the specified network device. The pre-set
> maximum for the combined channels is cpu dependent. Currently, for an
> i40e device, when the user sets a value between 64 and the maximum that
> the cpu can support for the combined parameter, the i40e driver displays the
> confusing info in dmesg to only show 64 as the RSS count regardless of what
> the accepted user input is as long as it is larger than 64.
> 
> This patch fixes the message in the i40e driver when the user uses ethtool -L
> to change the number of the combined channels to consistently display the
> user requested value if it is valid and accepted by ethtool.
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> Change-ID: Ia80a68bc844b779a49e0f76e7d3dcc915032d9af
> ---
> Testing Hints:
> 1. ethtool -l devname to show defaults
> 2. ethtool -L devname combined 72 to change the number of channels 3.
> ethtool -l devname to check settings 4. ethtool -S devname to verify 72
> queues(tx/rx) got set up 5. run dmesg to check the i40e driver provided info
> to be consistent:
>         i40e 0000:xx:00.x: User requested queue count/
>                 HW max RSS count:  72/64
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Works as described


