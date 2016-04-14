From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 14 Apr 2016 23:00:01 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/2] e1000e: Fix ptp time reset on
 network interruption
In-Reply-To: <e943a9f336c2dd089fdc6c1dafbf768bc0983075.1460517387.git.brian@walsh.ws>
References: <1455662685-7231-1-git-send-email-brian@walsh.ws>
 <e943a9f336c2dd089fdc6c1dafbf768bc0983075.1460517387.git.brian@walsh.ws>
Message-ID: <1460674801.28210.16.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-04-12 at 23:22 -0400, Brian Walsh wrote:
> Time is resetting on any interruption of network connectivity. This
> causes the clock to jump around by the leapsecond offset. It should
> only reset when the device is initialized.
> 
> Signed-off-by: Brian Walsh <brian@walsh.ws>

Jeff,

This patch is incorrect. I have an alternative I am proposing. The
first patch in the series is correct and can be used, but the 2nd patch
is incorrect, and I will propose a replacement. Can we drop this patch
from the queue?

I'll indicate the patch as a conflict when I submit my reworked patch.

Regards,
Jake
