From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 25 Apr 2016 23:04:35 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] e1000e:
 e1000e_cyclecounter_read():	incvalue is 32 bits, not 64
In-Reply-To: <1461167156-6737-1-git-send-email-dvlasenk@redhat.com>
References: <1461167156-6737-1-git-send-email-dvlasenk@redhat.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EF172A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Denys Vlasenko
> Sent: Wednesday, April 20, 2016 8:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Subject: [Intel-wired-lan] [PATCH 1/3] e1000e: e1000e_cyclecounter_read():
> incvalue is 32 bits, not 64
> 
> "incvalue" variable holds a result of "er32(TIMINCA) &
> E1000_TIMINCA_INCVALUE_MASK"
> and used in "do_div(temp, incvalue)" as a divisor.
> 
> Thus, "u64 incvalue" declaration is probably a mistake.
> Even though it seems to be a harmless one, let's fix it.
> 
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> CC: intel-wired-lan at lists.osuosl.org
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This patch threw a checkpatch warning for me:
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)

But all my regression systems are happy so...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
