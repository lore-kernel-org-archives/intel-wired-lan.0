From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 12 May 2015 01:04:12 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: i219 execute unit hang fix
	on	every reset or power state transition
In-Reply-To: <1429665301-10596-1-git-send-email-yanirx.lubetkin@intel.com>
References: <1429665301-10596-1-git-send-email-yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DC250A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Tuesday, April 21, 2015 6:15 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] e1000e: i219 execute unit hang fix on
> every reset or power state transition
> 
> after testing various cases, the conclusion is that the fix MUST be
> executed BEFORE
> any event that the HW is reset or transition to D3. to fix that I moved
> the execution
> to the relevant places but per Alexander Duyck's review, ensure now that
> the DMA is
> valid and was not freed before manipulating the ring.
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
