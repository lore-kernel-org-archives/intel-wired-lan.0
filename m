From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 12 Feb 2016 23:22:24 +0000
Subject: [Intel-wired-lan] [PATCH net-next V2 4/6] igb: call
	ndo_stop()	instead of dev_close() when running offline selftest
In-Reply-To: <1454487652-1545-5-git-send-email-sassmann@kpanic.de>
References: <1454487652-1545-1-git-send-email-sassmann@kpanic.de>,
 <1454487652-1545-5-git-send-email-sassmann@kpanic.de>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E89BFE@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Stefan Assmann [sassmann at kpanic.de]
> Sent: Wednesday, February 03, 2016 12:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH net-next V2 4/6] igb: call ndo_stop() instead of dev_close() when running offline selftest
> 
> Calling dev_close() causes IFF_UP to be cleared which will remove the
> interfaces routes and some addresses. That's probably not what the user
> intended when running the offline selftest. Besides this does not happen
> if the interface is brought down before the test, so the current
> behaviour is inconsistent.
> Instead call the net_device_ops ndo_stop function directly and avoid
> touching IFF_UP at all.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         | 2 ++
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
>  drivers/net/ethernet/intel/igb/igb_main.c    | 8 ++++----
>  3 files changed, 8 insertions(+), 6 deletions(-)

Checkpatch warns that externs should be avoided in .c files, but they pre-existed and are just being flagged due to the name changing, so...

Tested-by: Aaron Brown <aaron.f.brown@intel.com> 
