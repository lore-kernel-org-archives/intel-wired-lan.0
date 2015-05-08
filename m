From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 8 May 2015 20:28:20 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: remove call to do_div and
 sign mismatch warning
In-Reply-To: <1429671343-13453-1-git-send-email-yanirx.lubetkin@intel.com>
References: <1429671343-13453-1-git-send-email-yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DC0154@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Tuesday, April 21, 2015 7:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] e1000e: remove call to do_div and sign
> mismatch warning
> 
> fixes a warning that was reported by Yanjiang Jin
> <yanjiang.jin@windriver.com>
> by implementing the solution suggested by
> Alexander Duyck <alexander.h.duyck@redhat.com>.
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

