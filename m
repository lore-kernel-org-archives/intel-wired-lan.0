From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 31 Mar 2017 23:22:13 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Enable reading of wake up packet
In-Reply-To: <1490575475-8215-2-git-send-email-kim.tatt.chuah@intel.com>
References: <1490575475-8215-1-git-send-email-kim.tatt.chuah@intel.com>
 <1490575475-8215-2-git-send-email-kim.tatt.chuah@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5E4536@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Chuah, Kim Tatt
> Sent: Sunday, March 26, 2017 5:45 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Chuah, Kim Tatt <kim.tatt.chuah@intel.com>
> Subject: [Intel-wired-lan] [PATCH] igb: Enable reading of wake up packet
> 
> Currently, in igb_resume(), igb driver ignores the Wake Up Status (WUS)
> and Wake Up Packet Memory (WUPM) registers. This patch enables the igb
> driver to read the WUPM if the controller was woken by a wake up packet
> that is not more than 128 bytes long (maximum WUPM size), then pass it
> up the kernel network stack.
> 
> Signed-off-by: Chuah, Kim Tatt <kim.tatt.chuah@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_defines.h | 21 +++++++++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c      | 36
> +++++++++++++++++++++++++-
>  2 files changed, 56 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
