From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 17 Sep 2021 09:01:42 -0700
Subject: [Intel-wired-lan] [net-next,
 v1] net: e1000e: solve insmod 'Unknown symbol mutex_lock' error
In-Reply-To: <20210917141146.5822-1-chenhaoa@uniontech.com>
References: <20210917141146.5822-1-chenhaoa@uniontech.com>
Message-ID: <20c47a57-e7d7-d791-5c86-e27310672789@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/17/2021 7:11 AM, Hao Chen wrote:
> After I turn on the CONFIG_LOCK_STAT=y, insmod e1000e.ko will report:
> [    5.641579] e1000e: Unknown symbol mutex_lock (err -2)
> [   90.775705] e1000e: Unknown symbol mutex_lock (err -2)
> [  132.252339] e1000e: Unknown symbol mutex_lock (err -2)
> 
> This problem fixed after include <linux/mutex.h>.

Thanks for taking the time to send a patch.
Why do you think including a file will fix this? That error is usually
the user's fault for trying to use insmod which doesn't check module
dependencies.

The advice I usually give is to try modprobe instead, does the problem
still occur without this patch and just using modprobe?
