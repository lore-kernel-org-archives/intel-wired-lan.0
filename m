From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 6 Jan 2016 21:10:20 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix broken PFC with X550
In-Reply-To: <20151123183125.20877.67227.stgit@lin-nd1-054.jf.intel.com>
References: <20151123183125.20877.67227.stgit@lin-nd1-054.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D132D8@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Vasu Dev
> Sent: Monday, November 23, 2015 10:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix broken PFC with X550
> 
> PFC is configuration is skipped for X550 devices due to a incorrect device id
> check, fixing that to include X550 PFC configuration.
> 
> Signed-off-by: Vasu Dev <vasu.dev@intel.com>
> ---

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
The scope of my testing was limited to trying to find any issues that this patch might cause with standard (non-DCB) networking traffic.
